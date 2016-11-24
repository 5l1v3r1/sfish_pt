#
# (C) Tenable Network Security
#



include("compat.inc");

if (description) 
{
  script_id(23785);
  script_version("$Revision: 1.4 $");

  script_name(english:"Seditio Detection");
  script_summary(english:"Checks for presence of Seditio");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a content management system written in
PHP." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Seditio, a moduler website engine powered
by PHP and MySQL." );
 script_set_attribute(attribute:"see_also", value:"http://www.neocrome.net/list.php?c=sed" );
 script_set_attribute(attribute:"risk_factor", value:"None" );
 script_set_attribute(attribute:"solution", value:"n/a" );
script_end_attributes();

 
  script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");

  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");
 
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

init_cookiejar();

# Loop through directories.
if (thorough_tests) dirs = list_uniq(make_list("/seditio", cgi_dirs()));
else dirs = make_list(cgi_dirs());

installs = 0;
foreach dir (dirs) {
  res = http_get_cache(item:string(dir, "/index.php"), port:port, cookies: 1);
  if (res == NULL) exit(0);

  # If it's Sedtio.
  if
  (
    ! isnull(get_http_cookie(name: "SEDITIO")) ||
    'generator" content="Seditio by Neocrome' >< r[2] ||
    '<br /><a href="http://www.neocrome.net">Powered by Seditio</a><a id="footer"></a><br />' >< r[2]
  )
  {
    ver = NULL;

    # Try to identify the version number from docs/readme.htm
    r = http_send_recv3 (method: "GET", item:string (dir, "/docs/readme.htm"), port:port);
    if (isnull(r)) exit(0);

    pat = '<h1 id="top"></a>Seditio v([0-9][^<]+)</h1>';
    matches = egrep(pattern:pat, string:r[2]);
    if (matches)
    {
      foreach match (split(matches))
      {
        match = chomp(match);
        ver = eregmatch(pattern:pat, string:match);
        if (!isnull(ver))
        {
          ver = ver[1];
          break;
        }
      }
    }

    # If still unknown, just mark it as "unknown".
    if (isnull(ver)) ver = "unknown";

    if (dir == "") dir = "/";
    set_kb_item(
      name:string("www/", port, "/seditio"),
      value:string(ver, " under ", dir)
    );
    installations[dir] = ver;
    ++installs;

    # Scan for multiple installations only if "Thorough Tests" is checked.
    if (!thorough_tests) break;
  }
}


# Report any instances found unless Report verbosity is "Quiet".
if (installs && report_verbosity > 0) {
  if (installs == 1) {
    foreach dir (keys(installations)) {
      # empty - just need to set 'dir'.
    }
    if (ver == "unknown") {
      info = string("An unknown version of Seditio was detected on the remote host\nunder the path '", dir, "'.");
    }
    else {
      info = string("Seditio ", ver, " was detected on the remote host under\nthe path '", dir, "'.");
    }
  }
  else {
    info = string(
      "Multiple instances of Seditio were detected on the remote host:\n",
      "\n"
    );
    foreach dir (keys(installations)) {
      info = info + string("    ", installations[dir], ", installed under ", dir, "\n");
    }
    info = chomp(info);
  }

  security_note(port:port, extra:'\n'+info);
}

