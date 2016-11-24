#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(29868);
  script_version("$Revision: 1.7 $");

  script_cve_id("CVE-2008-0224");
  script_bugtraq_id(27152);
  script_xref(name:"OSVDB", value:"40101");

  script_name(english:"Newbb_plus Module for RunCMS Client-Ip Header SQL Injection");
  script_summary(english:"Tries to generate a SQL syntax error");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is prone to a
SQL injection attack." );
 script_set_attribute(attribute:"description", value:
"The version of RunCMS installed on the remote host fails to sanitize
user-supplied input to the 'Client-Ip' request header before using it
in a database query in the 'newbb_plus' module.  Regardless of PHP's
'magic_quotes_gpc' setting, an attacker may be able to exploit this
issue to manipulate database queries, leading to disclosure of
sensitive information, modification of data, or attacks against the
underlying database. 

Note that the module is not enabled by default." );
 script_set_attribute(attribute:"see_also", value:"http://www.milw0rm.com/exploits/4845" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P" );
script_end_attributes();


  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("runcms_detect.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");
include("url_func.inc");


port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);


# Test an install.
install = get_kb_item(string("www/", port, "/runcms"));
if (isnull(install)) exit(0);
matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
if (!isnull(matches))
{
  dir = matches[2];

  # Try to exploit the issue to generate a SQL syntax error.
  exploit = string("1.2.3.4' ", SCRIPT_NAME);
  exploit = urlencode(str:exploit);

  r = http_send_recv3(method:"GET", port:port,
    item:string(dir, "/modules/newbb_plus/"), 
    add_headers: make_array("Client-Ip: ", exploit));
  if (isnull(r)) exit(0);
  res = r[2];

  # There's a problem if we see a syntax error.
  if (
    '_whosonline where timestamp' >< res &&
    string(" OR user_ip='", exploit) >< res
  )
  {
    security_warning(port);
    set_kb_item(name: 'www/'+port+'/SQLInjection', value: TRUE);
    exit(0);
  }
}
