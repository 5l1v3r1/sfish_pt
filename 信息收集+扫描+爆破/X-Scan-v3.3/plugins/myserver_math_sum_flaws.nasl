#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
 script_id(14182);
 script_version ("$Revision: 1.6 $");
 script_bugtraq_id(10831);
 script_xref(name:"OSVDB", value:"53794");
 script_xref(name:"OSVDB", value:"53795");

 script_name(english:"MyServer 0.6.2 math_sum.mscgi Multiple Vulnerabilities");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server is hosting a CGI applciation that is affected by
multiple vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"The sample CGI math_sum.mscgi is installed on the remote web server.

The remote version of this CGI contain several issues which may allow
an attacker to execute a cross site scripting attack, to disable the
remote server remotely or to execute arbitrary code with the 
privileges of the server." );
 script_set_attribute(attribute:"see_also", value:"http://www.nessus.org/u?5666bf3a" );
 script_set_attribute(attribute:"solution", value:
"There is no known solution at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();

 script_summary(english:"Determine if math_sum.cgi is installed");
 script_category(ACT_GATHER_INFO);
 script_family(english:"CGI abuses");
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
 script_dependencie("http_version.nasl", "cross_site_scripting.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

include("http.inc");
include("misc_func.inc");
include("global_settings.inc");


port = get_http_port(default:80);

if(!get_port_state(port))exit(0);
if(get_kb_item(string("www/", port, "/generic_xss"))) exit(0);


foreach d (cgi_dirs())
{
  res = http_send_recv3(method:"GET", item:string(d, "/math_sum.mscgi"), port:port);

  if (isnull(res)) exit(1, "The remote web server did not respond.");
 
  if("<title>MyServer</title>" >< res[2] )
  {
    res = http_send_recv3(method:"GET", item:string(d, "/math_sum.mscgi?a=<script>foo</script>&b="), port:port);
    if(isnull(res)) exit(1, "The remote web server did not respond.");

    if ("<script>foo</script>" >< res[2])
    {
      security_hole(port);
      set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
      exit(0);
    }
  }
}

