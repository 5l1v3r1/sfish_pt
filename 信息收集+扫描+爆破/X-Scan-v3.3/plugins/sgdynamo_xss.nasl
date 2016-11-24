#
# This script written by Scott Shebby (12/2003) 
#
# See the Nessus Scripts License for details
#

# Changes by Tenable:
# - Revised description [RD]
# - Support for multiple HTTP directories [RD]
# - HTTP Keepalive support [RD]
# - Revised plugin title (5/27/09)
# - Updated to use compat.inc, added CVSS score (11/20/2009)


include("compat.inc");

if(description)
{
 script_id(11955);
 script_version ("$Revision: 1.12 $");
 script_cve_id("CVE-2002-0375");
 script_bugtraq_id(4720);
 script_xref(name:"OSVDB", value:"3458");

 script_name(english:"SGDynamo sgdynamo.exe HTNAME XSS");

 script_set_attribute(attribute:"synopsis", value:
"The remote hos has an application that is affected by a
cross-site scripting issue." );
 script_set_attribute(attribute:"description", value:
"The remote host is running the CGI 'sgdynamo.exe'. 

There is a bug in some versions of this CGI which makes it vulnerable to
a cross site scripting attack." );
 script_set_attribute(attribute:"solution", value:
"None at this time" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N" );

script_end_attributes();

 
 script_summary(english:"sgdynamo.exe XSS Vulnerability");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2003-2009 Scott Shebby");
 script_family(english:"CGI abuses : XSS");
 script_dependencie("find_service1.nasl", "http_version.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

#
# The script code starts here
#
include("http_func.inc");
include("http_keepalive.inc");

port = get_http_port(default:80);

if(!get_port_state(port))exit(0);

foreach dir (cgi_dirs())
{
 url = dir + "/sgdynamo.exe?HTNAME=<script>foo</script>";
 req = http_get(item:url, port:port);
 resp = http_keepalive_send_recv(port:port, data:req, bodyonly:1);
 if ( resp == NULL ) exit(0);
 if ( "<script>foo</script>" >< res )
 {
   security_warning(port);
   set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
   exit(0);
 }
}
