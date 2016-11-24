#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
  script_id(11909);
  script_version ("$Revision: 1.14 $");
  script_cve_id("CVE-2003-1138");
  script_bugtraq_id(8898);
  script_xref(name:"OSVDB", value:"19137");

  script_name(english:"Apache Double Slash GET Request Forced Directory Listing");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server is affected by an information disclosure
vulnerability." );
 script_set_attribute(attribute:"description", value:
"It is possible to obtain the listing of the content of the remote web
server root by sending the request 'GET // HTTP/1.0' This
vulnerability usually affects the default Apache configuration which
is shipped with Red Hat Linux, although it might affect other Linux
distributions or other web server. 

An attacker can exploit this flaw to browse the contents of the remote
web server and possibly find hidden links." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/342578/30/0/threaded" );
 script_set_attribute(attribute:"solution", value:
"Create an index file for each directory instead of default welcome
pages." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N" );

script_end_attributes();

  script_summary(english:"sends a GET // HTTP/1.0");
  script_category(ACT_GATHER_INFO);
  script_family(english:"Web Servers");
  script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
  script_dependencies("find_service1.nasl", "http_version.nasl");
  script_require_keys("www/apache");
  script_require_ports("Services/www", 80);
  exit(0);
}


#
# The script code starts here

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);

res = http_get_cache(item:"/", port:port);
if ( res == NULL ) exit(0);
if ( "Index of /" >< res) exit(0);

r = http_send_recv3(method:"GET", item:"//", port:port);
if (isnull(r)) exit(0);
res = r[2];
if ( !isnull(res) && "Index of /" >< res)
{
  if (report_verbosity)
  {
    report = string(
      "\n",
      "Here are the contents of the initial directory :\n",
      "\n",
      res
    );
    security_warning(port:port, extra:report);
  }
  else security_warning(port);
}
