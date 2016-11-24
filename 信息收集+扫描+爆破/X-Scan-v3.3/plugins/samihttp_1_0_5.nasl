#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(16468);
 script_version("$Revision: 1.6 $");
 script_bugtraq_id(12559);
 script_xref(name:"OSVDB", value:"13815");
 script_xref(name:"OSVDB", value:"13816");
 
 script_name(english:"Sami HTTP Server Multiple Remote Vulnerabilities");

 script_set_attribute(attribute:"synopsis", value:
"The remote server is affected by several flaws." );
 script_set_attribute(attribute:"description", value:
"The remote host seems to be running Sami HTTP Server, an HTTP server
for Windows.

The remote version of this software contains multiple vulnerabilities. 
Sami HTTP server is vulnerable to a denial of service attack.  An
attacker can exploit this flaw by sending '\r\n\r\n' string. 

Sami HTTP server is vulnerable to a directory traversal attack.  An
attacker may exploit this flaw to gain access to sensitive data like
password files." );
 script_set_attribute(attribute:"solution", value:
"Sami HTTP Server is not supported any more. Use another web server." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:P" );

 script_end_attributes();
 
 script_summary(english:"Checks for version of Sami HTTP server");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 script_family(english: "Web Servers");
 script_dependencie("find_service1.nasl", "no404.nasl", "http_version.nasl");
 script_require_ports("Services/www", 80);
 exit(0);
}

#
# The script code starts here
#
include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);

banner = get_http_banner(port: port);
if(!banner)exit(0);

if ( egrep(pattern:"Server:.*Sami HTTP Server v(0\.|1\.0\.[0-5][^0-9])", string:banner) ) 
 {
   security_warning(port);
 }

