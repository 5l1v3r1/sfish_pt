# 
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
 script_id(11786);
 script_version ("$Revision: 1.14 $");
 script_cve_id("CVE-2002-1919");
 script_bugtraq_id(4861);
 script_xref(name:"OSVDB", value:"53410");

 script_name(english:"VP-ASP shopexd.asp catalogid Parameter SQL Injection");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server has a ASP script that is affected by
a SQL injection vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host is using the VP-ASP software suite.

This set of CGIs is vulnerable to a SQL injection bug which 
may allow an attacker to take the control of the server as 
an administrator. From there, he can obtain the list of 
customers, steal their credit card information and more.

In addition to this, this software is vulnerable to various
file disclosure and cross site scripting flaws." );
 script_set_attribute(attribute:"solution", value:
"Upgrade to the latest version of VP-ASP." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();

 script_summary(english:"Determine if ProductCart is vulnerable to a sql injection attack");
 script_category(ACT_ATTACK);
 script_family(english:"CGI abuses");
 script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
 script_dependencie("http_version.nasl", "find_service1.nasl", "no404.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);

foreach dir ( cgi_dirs() )
{
 res = http_send_recv3(method:"GET", item:dir + "/shopexd.asp?catalogid='42", port:port);
 if (isnull(res)) exit(1, "The web server failed to respond.");
 
 if(egrep(pattern:"'catalogid='42'", string:res[2]))
 {
  security_hole(port);
  set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
  set_kb_item(name: 'www/'+port+'/SQLInjection', value: TRUE);
  exit(0);
 }
}
