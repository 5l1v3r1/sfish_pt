#
# (C) Tenable Network Security
#
if(description)
{
 script_id(14614);
 script_cve_id("CAN-2004-1640");
 script_bugtraq_id(11064);
 script_version("$Revision: 1.4 $");
 
 name["english"] = "XOOPS Dictionary Module Cross Scripting Vulnerability";

 script_name(english:name["english"]);
 
 desc["english"] = "
The remote host is running the Xoops Dictionary module.

The remote version of this software is vulnerable to a cross-site scripting
attack. An attacker can exploit it by compromising the parameters to the files
letter.php

This can be used to take advantage of the trust between a client and server 
allowing the malicious user to execute malicious JavaScript on 
the client's machine.

Solution : Upgrade to the latest version of this software
Risk factor: Medium";

 script_description(english:desc["english"]);
 
 summary["english"] = "Checks for the presence of an XSS bug in Xoops";
 
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004 Tenable Network Security");
 family["english"] = "CGI abuses : XSS";
 family["francais"] = "Abus de CGI";
 script_family(english:family["english"], francais:family["francais"]);
 script_dependencie("cross_site_scripting.nasl", "http_version.nasl");
 script_require_ports("Services/www", 80);
 exit(0);
}

#
# The script code starts here
#


include("http_func.inc");
include("http_keepalive.inc");

port = get_http_port(default:80);

if(!get_port_state(port))exit(0);
if(!can_host_php(port:port))exit(0);
if (  get_kb_item(string("www/", port, "/generic_xss")) ) exit(0);

function check(loc)
{
 req = http_get(item:string(loc, "/letter.php?<script>foo</script>"), port:port);

 r = http_keepalive_send_recv(port:port, data:req, bodyonly:1);
 if( r == NULL )exit(0);
 if('<script>foo</script>' >< r )
 {
 	security_warning(port);
	exit(0);
 }
}

foreach dir (cgi_dirs())
{
 check(loc:dir);
}
