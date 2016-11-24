#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description) {
  script_id(18190);
  script_version("$Revision: 1.8 $");

  script_cve_id("CVE-2005-1435");
  script_bugtraq_id(13472);
  script_xref(name:"OSVDB", value:"16304");

  script_name(english:"Open WebMail Shell Escape Arbitrary Command Execution");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a Perl application that allows
execution of arbitrary code." );
 script_set_attribute(attribute:"description", value:
"According to its banner, the version of Open WebMail installed on the
remote host may allow execution of arbitrary shell commands due to its
failure to ensure shell escape characters are removed from filenames
and other strings before trying to read from them." );
 script_set_attribute(attribute:"see_also", value:"http://www.nessus.org/u?e789a315" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Open WebMail 2.5.1-20050430 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:S/C:P/I:P/A:P" );
script_end_attributes();

 
  script_summary(english:"Checks for arbitrary execution vulnerability in Open WebMail");
  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");
  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
  script_dependencies("openwebmail_detect.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("http_func.inc");


port = get_http_port(default:80);
if (!get_port_state(port)) exit(0);


# Test an install.
install = get_kb_item(string("www/", port, "/openwebmail"));
if (isnull(install)) exit(0);
matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
if (!isnull(matches)) {
  ver = matches[1];

  # nb: intermediate releases of 2.51 below 20050430 are vulnerable,
  #     as are 2.50 and earlier releases.
  if (ver =~ "^(1\.|2\.([0-4]|50|51$|51 20050([0-3]|4[12])))")
    security_warning(port);
}
