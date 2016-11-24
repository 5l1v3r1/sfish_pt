#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(10127);
 script_version ("$Revision: 1.25 $");
 script_cve_id("CVE-1999-0266");
 script_bugtraq_id(1995);
 script_xref(name:"OSVDB", value:"101");

 script_name(english:"Multiple Vendor info2www CGI Arbitrary Command Execution");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server is running a CGI that is affected by a remote
command execution vulnerability." );
 script_set_attribute(attribute:"description", value:
"The 'info2www' CGI is installed. This CGI has a well known security 
flaw that lets an attacker execute arbitrary commands with the 
privileges of the http daemon (usually root or nobody)." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/1998_1/0299.html" );
 script_set_attribute(attribute:"solution", value:
"There is no known solution at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C" );
script_end_attributes();
 script_summary(english:"Checks for the presence of /cgi-bin/info2www");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 1999-2009 Tenable Network Security, Inc.");
 script_family(english:"CGI abuses");
 script_dependencie("http_version.nasl", "find_service1.nasl", "no404.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

#
# The script code starts here
#

include("http.inc");
include("global_settings.inc");
include("misc_func.inc");

port = get_http_port(default:80);

if(!get_port_state(port))exit(0);

foreach dir (cgi_dirs())
{
  res = http_send_recv3(method:"GET", item:string(dir, "/info2www"), port:port);
  if (isnull(res)) exit(1, "The remote web server did not respond.");

  if(egrep(pattern:".*generated by info2www 1\.[01][^0-9].*", string:res[2])){
	security_hole(port);
	exit(0);
  }
}
