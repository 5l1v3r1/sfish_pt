#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description)
{
  script_id(33849);
  script_version("$Revision: 1.10 $");

  script_cve_id(
    "CVE-2007-4850", 
    "CVE-2008-3658", 
    "CVE-2008-3659",
    "CVE-2008-3660"
  );
  script_bugtraq_id(27413, 30649, 31612, 33542);
  script_xref(name:"OSVDB", value:"43219");
  script_xref(name:"Secunia", value:"31409");

  script_name(english:"PHP < 4.4.9 Multiple Vulnerabilities");
  script_summary(english:"Checks version of PHP");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server uses a version of PHP that is affected by
multiple issues." );
 script_set_attribute(attribute:"description", value:
"According to its banner, the version of PHP installed on the remote
host is older than 4.4.9.  Such versions may be affected by several
security issues :

  - There are unspecified issues in the bundled PCRE library
    fixed by version 7.7.

  - A buffer overflow in the 'imageloadfont()' function in
    'ext/gd/gd.c' can be triggered when a specially crafted
    font is given. (CVE-2008-3658)

  - A buffer overflow exists in the internal 'memnstr()'
    function, which is exposed to userspace as 'explode()'.
    (CVE-2008-3659)

  - A denial of service vulnerability exists when a 
    filename contains 2 dots. (CVE-2008-3660)

  - An 'open_basedir' handling issue in the curl extension.

  - 'mbstring.func_overload' set in '.htaccess' becomes 
    global.

Note that the release announcement states this will be the last
release for the PHP 4.4 series." );
 script_set_attribute(attribute:"see_also", value:"http://www.openwall.com/lists/oss-security/2008/08/08/2" );
 script_set_attribute(attribute:"see_also", value:"http://www.php.net/releases/4_4_9.php" );
 script_set_attribute(attribute:"see_also", value:"http://www.php.net/ChangeLog-4.php#4.4.9" );
 script_set_attribute(attribute:"see_also", value:"http://bugs.php.net/bug.php?id=27421" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to PHP version 4.4.9 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("backport.inc");
include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);


banner = get_http_banner(port:port);
if (banner)
{
  ver = get_php_version(banner:banner);
  if (ver && ver =~ "PHP/(3\.|4\.([0-3]\.|4\.[0-8]($|[^0-9])))")
  {
    if (report_verbosity)
    {
      ver = strstr(ver, "PHP/") - "PHP/";
      report = string(
        "\n",
        "PHP version ", ver, " appears to be running on the remote host based on\n"
      );

      if (egrep(pattern:"Server:.*PHP/[0-9].", string:banner))
      {
        line = egrep(pattern:"Server:.*PHP/[0-9].", string:banner);
        report = string(
          report, 
          "the following Server response header :\n",
          "\n",
          "  ", line
        );
      }
      else if (egrep(pattern:"^X-Powered-By:.*PHP/[0-9]", string:banner))
      {
        line = egrep(pattern:"^X-Powered-By:.*PHP/[0-9]", string:banner);
        report = string(
          report, 
          "the following X-Powered-By response header :\n",
          "\n",
          "  ", line
        );
      }
      security_hole(port:port, extra:report);
    }
    else security_hole(port);
  }
}
