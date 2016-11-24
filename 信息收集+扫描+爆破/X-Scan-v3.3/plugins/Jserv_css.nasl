#
# This script was written by Matt Moore <matt.moore@westpoint.ltd.uk>
#
# See the Nessus Scripts License for details
#

# Changes by Tenable:
# - Revised plugin title (5/19/09)


include("compat.inc");

if(description)
{
 script_id(10957);
 script_version ("$Revision: 1.23 $");

 script_xref(name:"OSVDB", value:"54588");
 script_xref(name:"OSVDB", value:"54589");

 script_name(english:"Apache JServ Nonexistent JSP Request XSS");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server is vulnerable to a cross-site scripting issue." );
 script_set_attribute(attribute:"description", value:
"Older versions of JServ (including the version shipped with Oracle9i App 
Server v1.0.2) are vulnerable to a cross site scripting attack using a 
request for a nonexistent .JSP file." );
 script_set_attribute(attribute:"solution", value:
"Upgrade to the latest version of JServ available at http://java.apache.org. 
Also consider switching from JServ to TomCat, since JServ is no longer 
maintained." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N" );

script_end_attributes();

 script_summary(english:"Tests for JServ Cross Site Scripting");
 script_category(ACT_ATTACK);
 script_copyright(english:"This script is Copyright (C) 2002-2009 Matt Moore");
 script_family(english: "CGI abuses : XSS");
 script_dependencie("http_version.nasl", "cross_site_scripting.nasl");
 script_exclude_keys("Settings/disable_cgi_scanning");
 script_require_ports("Services/www", 80);
 exit(0);
}

# Check starts here
include("http_func.inc");
include("http_keepalive.inc");

port = get_http_port(default:80);

if(get_kb_item(string("www/", port, "/generic_xss")))exit(0);


banner = get_http_banner(port:port);
if ( ! banner || "JServ" >!< banner ) exit(0);

if(get_port_state(port))
{ 
 req = http_get(item:"/a.jsp/<SCRIPT>alert(document.domain)</SCRIPT>", port:port);
 res = http_keepalive_send_recv(port:port, data:req, bodyonly:1);
 if( res == NULL ) exit(0);
 if("<SCRIPT>alert(document.domain)</SCRIPT>" >< res)
 {
   security_warning(port);
   set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
 }
}
