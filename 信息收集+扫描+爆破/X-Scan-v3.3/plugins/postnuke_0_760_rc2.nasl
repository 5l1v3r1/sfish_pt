#
# (C) Tenable Network Security
#


include("compat.inc");

if (description) {
  script_id(17240);
  script_version("$Revision: 1.9 $");

  script_cve_id("CVE-2005-0615", "CVE-2005-0616", "CVE-2005-0617");
  script_bugtraq_id(12683, 12684, 12685);
  script_xref(name:"OSVDB", value:"14282");
  script_xref(name:"OSVDB", value:"15922");
  script_xref(name:"OSVDB", value:"15923");
  script_xref(name:"OSVDB", value:"15924");

  script_name(english:"PostNuke <= 0.760 RC2 Multiple Vulnerabilities");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that suffers from
multiple vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"The remote host is running PostNuke version 0.760 RC2 or older.  These
versions suffer from several vulnerabilities, among them :

  - SQL injection vulnerability in the News, NS-Polls and 
    NS-AddStory modules.
  - SQL injection vulnerability in the Downloads module.
  - Cross-site scripting vulnerabilities in the Downloads
    module.
  - Possible path disclosure vulnerability in the News module.

An attacker may use the SQL injection vulnerabilities to obtain the
password hash for the administrator or to corrupt the database
database used by PostNuke. 

Exploiting the XSS flaws may enable an attacker to inject arbitrary
script code into the browser of site administrators leading to
disclosure of session cookies." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2005-02/0471.html" );
 script_set_attribute(attribute:"see_also", value:"http://news.postnuke.com/Article2669.html" );
 script_set_attribute(attribute:"solution", value:
"Either upgrade and apply patches for 0.750 or upgrade to 0.760 RC3 or
later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();


  script_summary(english:"Detects multiple vulnerabilities in PostNuke 0.760 RC2 and older");

  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");

  script_dependencies("postnuke_detect.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);
if (!can_host_php(port:port))exit(0);

kb = get_kb_item("www/" + port + "/postnuke" );
if (! kb) exit(0);
install = eregmatch(pattern:"(.*) under (.*)", string:kb );
ver = install[1];
dir = install[2];

# Try the SQL injection exploits.
exploits = make_list(
  "catid='cXIb8O3",
  "name=Downloads&req=search&query=&show=cXIb8O3",
  "name=Downloads&req=search&query=&orderby="
);

foreach exploit (exploits) {
  if (test_cgi_xss(port: port, cgi: "/index.php", qs: exploit, dirs: make_list(dir),
 sql_injection: 1, high_risk: 1,
 pass_re: "DB Error: getArticles:|Fatal error: .+/modules/Downloads/dl-search.php"))
  exit(0);
}
