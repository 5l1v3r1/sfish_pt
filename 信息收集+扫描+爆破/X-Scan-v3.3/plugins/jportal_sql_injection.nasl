#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if(description)
{
 script_id(12256);
 script_version("$Revision: 1.10 $");
 script_cve_id("CVE-2004-2036");
 script_bugtraq_id(10430);
 script_xref(name:"OSVDB", value:"6503");
 script_xref(name:"Secunia", value:"11737");

 script_name(english:"jPortal print.inc.php id Parameter SQL Injection");
 script_summary(english:"SQL Injection");
 
 script_set_attribute(
   attribute:"synopsis",
   value:string(
     "A web application on the remote host has a SQL injection\n",
     "vulnerability."
   )
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
     "The remote host appears to be running the jPortal CGI suite.\n\n",
     "There is a SQL injection vulnerability in the 'id' parameter of\n",
     "print.php.  A remote attacker could exploit this to execute\n",
     "arbitrary SQL queries, which could be used to gain administrative\n",
     "access to this host."
   )
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://archives.neohapsis.com/archives/bugtraq/2004-05/0294.html"
 );
 script_set_attribute(
   attribute:"solution", 
   value:"There is no known solution at this time."
 );
 script_set_attribute(
   attribute:"cvss_vector", 
   value:"CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P"
 );
 script_end_attributes();

 script_category(ACT_GATHER_INFO);
 script_family(english:"CGI abuses");
 
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");

 script_dependencie("find_service1.nasl", "http_version.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");

 exit(0);
}

# Check starts here

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80);
if ( ! can_host_php(port:port) ) exit(0);


foreach dir (cgi_dirs()) 
{
  url = string(dir, "/print.php?what=article&id='");
  res = http_send_recv3(method:"GET", item:url, port:port);
  if (isnull(res)) exit(1, "The server did not respond.");

  if (egrep(pattern:"mysql_fetch_array\(\).*MySQL", string:res[2]) ) 
  {
    if (report_verbosity > 0)
    {
      report = string(
        "\n",
        "Nessus detected this issue based on the error message generated by\n",
        "requesting the following URL :\n\n",
        "  ", build_url(qs:url, port:port), "\n"
      );
      security_hole(port:port, extra:report);
    }
    else security_hole(port);

    set_kb_item(name: 'www/'+port+'/SQLInjection', value: TRUE);
    exit(0);
  }
 }
