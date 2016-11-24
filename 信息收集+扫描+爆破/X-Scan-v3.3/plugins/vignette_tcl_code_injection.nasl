#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(11749);
 script_version("$Revision: 1.11 $");

 script_cve_id("CVE-2003-0398", "CVE-2003-0399", "CVE-2003-0402", "CVE-2003-0405");
 script_bugtraq_id(7683, 7685, 7690, 7691, 7692);
 script_xref(name:"OSVDB", value:"4859");
 script_xref(name:"OSVDB", value:"4860");
 script_xref(name:"OSVDB", value:"4909");
 script_xref(name:"OSVDB", value:"4912");
 script_xref(name:"OSVDB", value:"4913");
 
 script_name(english:"Vignette StoryServer < 6.0.4 Arbitrary TCL Code Execution");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host has an application that may allow arbitrary
code execution on the remote system." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Vignette StoryServer v6, a web 
interface to Vignette's Content Management suite.

A flaw in this product may allow an attacker to inject
arbitrary code in this server.

*** Nessus could not determine the existence of this vulnerability
*** so this might be a false positive" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Vignette 6.0.4 or newer." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();

 
 script_summary(english:"Checks the version of the remote Vignette StoryServer"); 
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
 script_family(english:"CGI abuses");
 script_dependencie("find_service1.nasl", "http_version.nasl", "no404.nasl");
 script_require_ports("Services/www", 80);
 exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);

dirs = get_kb_list(string("www/", port, "/content/directories"));
if(isnull(dirs)) dirs = make_list("");
else dirs = make_list(dirs);

foreach dir (dirs)
{
 res = http_send_recv3(method:"GET", item:string(dir , "/"), port:port);
 
 if(isnull(res)) exit(1,"Null response to "+ dir + " request.");
 if("Vignette StoryServer v6" >< res[2]) 
 {
  security_hole(port);
 }
}
