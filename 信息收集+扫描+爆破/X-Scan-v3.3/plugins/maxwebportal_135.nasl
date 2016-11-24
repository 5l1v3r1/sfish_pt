#
# (C) Tenable Network Security
#



include("compat.inc");

if (description) {
  script_id(18248);
  script_version("$Revision: 1.10 $");

  script_cve_id("CVE-2005-1561", "CVE-2005-1562");
  script_bugtraq_id(13601);
  if (defined_func("script_xref")) {
    script_xref(name:"OSVDB", value:"16501");
    script_xref(name:"OSVDB", value:"16502");
    script_xref(name:"OSVDB", value:"16503");
    script_xref(name:"OSVDB", value:"16504");
    script_xref(name:"OSVDB", value:"16505");
    script_xref(name:"OSVDB", value:"16506");
    script_xref(name:"OSVDB", value:"16510");
    script_xref(name:"OSVDB", value:"16511");
    script_xref(name:"OSVDB", value:"16512");
    script_xref(name:"OSVDB", value:"16513");
    script_xref(name:"OSVDB", value:"16514");
    script_xref(name:"OSVDB", value:"16515");
    script_xref(name:"OSVDB", value:"16516");
    script_xref(name:"OSVDB", value:"16517");
    script_xref(name:"OSVDB", value:"16518");
    script_xref(name:"OSVDB", value:"16519");
  }

  name["english"] = "MaxWebPortal <= 1.35 Multiple Vulnerabilities";
  script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains an ASP application that is affected by
multiple flaws." );
 script_set_attribute(attribute:"description", value:
"According to its banner, the remote host is running a version of
MaxWebPortal that is prone to multiple cross-site scripting and SQL
injection vulnerabilities.  Exploitation of these flaws may result in
password theft and/or site defacement." );
 script_set_attribute(attribute:"see_also", value:"http://www.hackerscenter.com/archive/view.asp?id=2542" );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2005-05/0122.html" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();

 
  summary["english"] = "Checks for multiple vulnerabilities in MaxWebPortal <= 1.35";
  script_summary(english:summary["english"]);
 
  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("http_func.inc");
include("http_keepalive.inc");


port = get_http_port(default:80);
if (!get_port_state(port)) exit(0);
if (!can_host_asp(port:port)) exit(0);


# Check various directories for MaxWebPortal.
foreach dir (cgi_dirs()) {
  # Pull up the site info page.
  req = http_get(item:string(dir, "/site_info.asp"), port:port);
  res = http_keepalive_send_recv(port:port, data:req, bodyonly:TRUE);
  if (res == NULL) exit(0);

  # Test the version number.
  #
  # nb: a more complete version number can be found in "site_info.asp".
  if (
    "This page is generated by MaxWebPortal" >< res && 
    egrep(string:res, pattern:'acronym title="Version: 1\\.([0-2]|3[0-5])')
  ) {
    security_hole(port);
    set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
    set_kb_item(name: 'www/'+port+'/SQLInjection', value: TRUE);
    exit(0);
  }
}
