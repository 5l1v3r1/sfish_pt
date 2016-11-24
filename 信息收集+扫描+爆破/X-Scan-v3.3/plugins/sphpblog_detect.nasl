#
# (C) Tenable Network Security
#



include("compat.inc");

if (description) 
{
  script_id(34109);
  script_version("$Revision: 1.5 $");

  script_name(english:"Simple PHP Blog Detection");
  script_summary(english:"Checks for presence of Simple PHP Blog");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a blog application written in PHP." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Simple PHP Blog, an open source blog
application that uses flat text files." );
 script_set_attribute(attribute:"see_also", value:"http://www.simplephpblog.com/" );
 script_set_attribute(attribute:"risk_factor", value:"None" );
 script_set_attribute(attribute:"solution", value:"n/a" );
script_end_attributes();

 
  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");
 
  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("http_func.inc");
include("http_keepalive.inc");
include("misc_func.inc");


port = get_http_port(default:80);
if (!get_port_state(port)) exit(0);
if (!can_host_php(port:port)) exit(0);


# Loop through various directories.
if (thorough_tests) dirs = list_uniq(make_list("/sphpblog", "/blog", cgi_dirs()));
else dirs = make_list(cgi_dirs());

installs = 0;
foreach dir (dirs)
{
  req = http_get(item:string(dir, "/login.php"), port:port);
  res = http_keepalive_send_recv(port:port, data:req, bodyonly:TRUE);
  if (res == NULL) exit(0);

  # If it's Simple PHP Blog...
  if (
    'sphpblog.png" alt="Powered by Simple PHP Blog"' >< res ||
    (
      '<form action="login_cgi.php" ' >< res &&
      '<div class="blog_subject">Login' >< res
    ) ||
    '<meta name="generator" content="Simple PHP Blog' >< res ||
    'alt="button_sphpblog.png"' >< res
  )
  {
    ver = NULL;

    pat = '<meta name="generator" content="Simple PHP Blog ([^"]+)"';
    matches = egrep(string:res, pattern:pat);
    if (matches)
    {
      foreach match (split(matches))
      {
        match = chomp(match);
        item = eregmatch(pattern:pat, string:match);
        if (!isnull(item))
        {
          ver = item[1];
          break;
        }
      }
    }

    if (isnull(ver)) {
      pat = 'button_sphpblog\\.png" [^>]+="Powered by Simple PHP Blog ([^"]+)"';
      matches = egrep(string:res, pattern:pat);
      if (matches)
      {
        foreach match (split(matches))
        {
          match = chomp(match);
          item = eregmatch(pattern:pat, string:match);
          if (!isnull(item))
          {
            ver = item[1];
            break;
          }
        }
      }
    }

    if (isnull(ver))
    {
      # Try to grab the version from the changelog.
      req = http_get(item:string(dir, "/docs/CHANGELOG.TXT"), port:port);
      res = http_keepalive_send_recv(port:port, data:req, bodyonly:TRUE);
      if (res == NULL) exit(0);

      if ("Version History" >< res)
      {
        snippet = strstr(res, "Version History");
        if ("======" >< snippet)
        {
          snippet = snippet - strstr(snippet, "======");
          foreach line (split(snippet, keep:FALSE))
          {
            if (line =~ "^[0-9]+\.[0-9.]+") 
            {
              ver = line;
              break;
            }
          }
        }
      }
    }

    # If still unknown, just mark it as "unknown".
    if (isnull(ver)) ver = "unknown";

    if (dir == "") dir = "/";
    set_kb_item(
      name:string("www/", port, "/sphpblog"),
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
    if (ver == "unknown")
    {
      info = string("An unknown version of Simple PHP Blog was detected on the remote host\nunder the path '", dir, "'.\n");
    }
    else
    {
      info = string("Simple PHP Blog ", ver, " was detected on the remote host under the\npath '", dir, "'.\n");
    }
  }
  else
  {
    info = string(
      "Multiple instances of Simple PHP Blog were detected on the remote host :\n",
      "\n"
    );
    foreach dir (keys(installations))
    {
      info = info + string("  - ", installations[dir], ", installed under '", dir, "'.\n");
    }
    info = chomp(info);
  }

  if (report_verbosity)
  {
    report = string(
      "\n",
      info
    );
    security_note(port:port, extra:report);
  }
  else security_note(port);
}
