#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description) {
  script_id(17985);
  script_version("$Revision: 1.9 $");

  script_cve_id("CVE-2005-1007");
  script_bugtraq_id(13001);
  script_xref(name:"OSVDB", value:"15257");

  script_name(english:"CommuniGate Pro LISTS Module Malformed Multipart Message DoS");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote mail server is prone to a denial of service attack." );
 script_set_attribute(attribute:"description", value:
"According to its banner, the version of CommuniGate Pro running on the
remote host is prone to an unspecified denial of service vulnerability
arising from a flaw in the LISTS module.  An attacker may be able to
crash the server by sending a malformed multipart message to a list." );
 script_set_attribute(attribute:"see_also", value:"http://www.stalker.com/CommuniGatePro/History43.html" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to CommuniGate Pro 4.3c3 or newer." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P" );
script_end_attributes();

 
  script_summary(english:"Checks for denial of service vulnerability in CommuniGate Pro LISTS module");
  script_category(ACT_GATHER_INFO);
  script_family(english:"SMTP problems");
  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
  script_dependencies("smtpserver_detect.nasl");
  script_require_ports("Services/smtp", 25);

  exit(0);
}


include("smtp_func.inc");


port = get_kb_item("Services/smtp");
if (!port) port = 25;
if (!get_port_state(port)) exit(0);
if (get_kb_item('SMTP/'+port+'/broken')) exit(0);


banner = get_smtp_banner(port:port);
if ( banner &&
    egrep(
    string:banner, 
    pattern:"CommuniGate Pro ([0-3]|4\.[0-2]|4\.3([ab][0-9]|c[0-2]))"
  )
) security_warning(port);
