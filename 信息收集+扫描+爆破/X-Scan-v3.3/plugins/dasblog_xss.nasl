#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if(description)
{
 script_id(14639);
 script_version("$Revision: 1.10 $");
 script_cve_id("CVE-2004-1657");
 script_bugtraq_id(11086);
 script_xref(name:"OSVDB", value:"9453");
 script_xref(name:"Secunia", value:"12416");
 
 script_name(english:"DasBlog Activity / Event Viewer Multiple HTTP Header XSS");
 script_summary(english:"Checks for the presence of an XSS bug in dasBlog");

 script_set_attribute(
   attribute:"synopsis",
   value:string(
     "The remote web application has multiple cross-site scripting\n",
     "vulnerabilities."
   )
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
      "The remote host is running dasBlog, a .NET blog system. According to\n",
      "its version number, it is vulnerable to multiple cross-site scripting\n",
      "issues.  It is reported that versions up to and including 1.6.0 are\n",
      "vulnerable.\n\n",
      "The application does not sanitize the Referer and User-Agent HTTP\n",
      "headers.  An attacker could use this to trick a user into executing\n",
      "arbitrary script code in the context of the web server."
   )
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://www.nessus.org/u?f2429b2e"
 );
 script_set_attribute(
   attribute:"solution", 
   value:"Apply the vendor patch referenced in the advisory."
 );
 script_set_attribute(
   attribute:"cvss_vector", 
   value:"CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N"
 );
 script_end_attributes();

 script_category(ACT_GATHER_INFO);
 script_family(english:"CGI abuses : XSS");

 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
 script_dependencie("http_version.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

#
# The script code starts here
#


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);

function check(loc)
{
 local_var url, r;

 url = string(loc, "/CategoryView.aspx?category=nessus");
 r = http_send_recv3(method:"GET", item:url, port:port);
 if( isnull(r) ) exit(0);

 if( 'newtelligence' >< r[2] && 
     'dasBlog' >< r[2] &&
      egrep(pattern:"(Powered By:)? newtelligence dasBlog (0\.|1\.([0-5]\.|6\.[0-9][0-9][0-9][0-9]\.0))", string:r[2]) )
 {
 	security_warning(port);
	set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
	exit(0);
 }
}

foreach dir (cgi_dirs())
{
 check(loc:dir);
}

