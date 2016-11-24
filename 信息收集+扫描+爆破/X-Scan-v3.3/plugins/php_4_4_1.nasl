#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description) {
  script_id(20111);
  script_version("$Revision: 1.8 $");

  script_cve_id("CVE-2005-2491", "CVE-2005-3388", "CVE-2005-3389", "CVE-2005-3390");
  script_bugtraq_id(14620, 15248, 15249, 15250);
  script_xref(name:"OSVDB", value:"18906");
  script_xref(name:"OSVDB", value:"20406");
  script_xref(name:"OSVDB", value:"20407");
  script_xref(name:"OSVDB", value:"20408");

  script_name(english:"PHP < 4.4.1 / 5.0.6 Multiple Vulnerabilities");
  script_summary(english:"Checks for multiple vulnerabilities in PHP < 4.4.1 / 5.0.6");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server uses a version of PHP that is affected by
multiple flaws." );
 script_set_attribute(attribute:"description", value:
"According to its banner, the version of PHP installed on the remote
host is older than 4.4.1 or 5.0.6.  Such versions fail to protect the
'$GLOBALS' superglobals variable from being overwritten due to
weaknesses in the file upload handling code as well as the 'extract()'
and 'import_request_variables()' functions.  Depending on the nature
of the PHP applications on the affected host, exploitation of this
issue may lead to any number of attacks, including arbitrary code
execution. 

In addition, these versions may enable an attacker to exploit an
integer overflow flaw in certain certain versions of the PCRE library,
to enable PHP's 'register_globals' setting even if explicitly disabled
in the configuration, and to launch cross-site scripting attacks
involving PHP's 'phpinfo()' function." );
 script_set_attribute(attribute:"see_also", value:"http://www.hardened-php.net/advisory_182005.77.html" );
 script_set_attribute(attribute:"see_also", value:"http://www.hardened-php.net/advisory_182005.78.html" );
 script_set_attribute(attribute:"see_also", value:"http://www.hardened-php.net/advisory_202005.79.html" );
 script_set_attribute(attribute:"see_also", value:"http://www.php.net/release_4_4_1.php" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to PHP version 4.4.1 / 5.0.6 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");

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
  if (ver && ver =~ "PHP/(3\.|4\.([0-3]\.|4\.0)|5\.0\.[0-5])")
  {
    set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);

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
