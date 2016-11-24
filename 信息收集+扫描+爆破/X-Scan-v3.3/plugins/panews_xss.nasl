#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(16479);
 script_version("$Revision: 1.8 $");

 script_cve_id("CVE-2005-0485");
 script_bugtraq_id(12576);
 script_xref(name:"OSVDB", value:"13931");

 script_name(english:"paNews comment.php showpost Parameter XSS");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is affected by a
cross-site scripting issue." );
 script_set_attribute(attribute:"description", value:
"According to its banner, the remote host is running a version of
paNews that fails to sanitize input to the 'showpost' parameter of the
'comment.php' script before using it to generate dynamic web content. 
By coercing an unsuspecting user into visiting a malicious website, an
attacker may be able to possibly steal credentials or execute
browser-side code." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2005-02/0239.html" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N" );
script_end_attributes();

 
 script_summary(english:"Checks version of paNews");
 script_category(ACT_GATHER_INFO);
 script_family(english:"CGI abuses : XSS");
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 script_dependencies("panews_detect.nasl");
 script_exclude_keys("Settings/disable_cgi_scanning");
 script_require_ports("Services/www", 80);

 exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);


# Test an install.
install = get_kb_item(string("www/", port, "/panews"));
if (isnull(install)) exit(0);
matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
if (!isnull(matches)) {
  ver = matches[1];

  if (ver && ver =~  "^([0-1]\.|2\.0b[0-4])$")
  {
   security_warning(port);
   set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
  }
}
