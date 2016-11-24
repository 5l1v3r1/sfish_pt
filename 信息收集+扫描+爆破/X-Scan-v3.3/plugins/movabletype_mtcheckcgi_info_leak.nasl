#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if (description)
{
  script_id(42842);
  script_version("$Revision: 1.1 $");

  script_name(english:"Movable Type mt-check.cgi Information Disclosure");
  script_summary(english:"Checks for the existence of mt-check.cgi");

  script_set_attribute(
    attribute:"synopsis",
    value:"A web application running on the remote host is leaking information."
  );
  script_set_attribute(
    attribute:"description",
    value:string(
"The Movable Type installation on the remote web server is leaking
information via mt-check.cgi.  This CGI determines if the Perl modules
required by Movable Type are installed, and is only intended to be
used prior to installation.  It discloses path information, operating
system type, Perl version, and the versions of several Perl modules. 
A remote attacker could use this information to mount further
attacks."
    )
  );
  script_set_attribute(
    attribute:"solution",
    value:"Remove this file from the web server."
  );
  script_set_attribute(
    attribute:"cvss_vector",
    value:"CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N"
  );
  script_set_attribute(
    attribute:"plugin_publication_date",
    value:"2009/11/18"
  );
  script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");

  script_dependencies("movabletype_detect.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");
include("webapp_func.inc");


port = get_http_port(default:80);
install = get_install_from_kb(appname:'movabletype', port:port);
if (isnull(install))
  exit(1, "Movable Type install not found in KB for port " + port + ".");

url = install['dir'] + '/mt-check.cgi';
res = http_send_recv3(method:"GET", item:url, port:port);
if (isnull(res)) exit(1, "The web server on port " + port + " didn't respond.");

if (
  '<title>Movable Type System Check [mt-check.cgi]</title>' >< res[2] &&
  'MT home directory' >< res[2]
)
{
  if (report_verbosity > 0)
  {
    trailer = NULL;

    # If we're verbose, attempt to extract some information of interest
    if (report_verbosity > 1)
    {
      info = '';
      patterns = make_array(
        'Movable Type version:</strong> <code>([0-9.]+)</code>', 'Movable Type version',
        'MT home directory:</strong> <code>([^<]+)</code>', 'Movable Type path',
        '<strong>Operating system:</strong> ([^<]+)</li>', 'Operating system',
        'Perl version:</strong> <code>([0-9.]+)</code>', 'Perl version'
      );

      foreach pat (keys(patterns))
      {
        match = eregmatch(string:res[2], pattern:pat);
        if (match) info += '  ' + patterns[pat] + ' : ' + match[1] + '\n';
      }

      # If any info was extracted, make sure it makes it into the report
      if (info != '')
        trailer = 'Which displays information such as :\n\n' + info;
    }
      
    report = get_vuln_report(items:url, port:port, trailer:trailer);
    security_warning(port:port, extra:report);
  }
  else security_warning(port);
}
else
{
  mt_url = build_url(qs:install['dir'] + '/', port:port);
  exit(0, "The Movable Type install at " + mt_url + " is not affected.");
}

