#
# (C) Tenable Network Security
#


include("compat.inc");

if (description) {
  script_id(18036);
  script_version("$Revision: 1.13 $");
  script_cve_id("CVE-2005-1077", "CVE-2005-1078", "CVE-2005-2043");
  script_bugtraq_id(13131, 13128, 13127, 13126, 13982, 13983);
  script_xref(name:"OSVDB", value:"15632");
  script_xref(name:"OSVDB", value:"15633");
  script_xref(name:"OSVDB", value:"15634");
  script_xref(name:"OSVDB", value:"15636");
  script_xref(name:"OSVDB", value:"17408");
  script_xref(name:"OSVDB", value:"17409");

  script_name(english:"XAMPP < 1.4.14 Multiple Vulnerabilities");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host contains several applications that may use default
passwords and be prone to cross-site scripting and directory traversal
attacks." );
 script_set_attribute(attribute:"description", value:
"The remote host is running XAMPP, an Apache distribution containing
MySQL, PHP, and Perl.  It is designed for easy installation and
administration. 

The remote version of this software contains various security flaws
and password disclosure weaknesses which may allow an attacker to
perform cross-site scripting attacks against the remote host or to
gain administrative access on the remote host if no password has been
set." );
 script_set_attribute(attribute:"see_also", value:"http://marc.info/?l=full-disclosure&m=111330048629182&w=2" );
 script_set_attribute(attribute:"see_also", value:"http://sourceforge.net/project/shownotes.php?release_id=335710" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to XAMPP 1.4.14 or newer." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P" );
script_end_attributes();

 
  summary["english"] = "Checks for the version of XAMPP";
  script_summary(english:summary["english"]);
 
  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");

  script_dependencie("http_version.nasl");
  script_require_ports("Services/www", 80);
  script_exclude_keys("Settings/disable_cgi_scanning");

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);

r = http_send_recv3(method: "GET", item:"/xampp/start.php", port:port);
if (isnull(r)) exit(0);
res = r[2];
if ( egrep(pattern:"(Bienvenido a|Willkommen zu|Welcome to) XAMPP .* 1\.([0-3]\.|4\.[0-9][^0-9]|4\.1[0-3][^0-9])", string:res) )
{
 security_warning(port);
 set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
}


