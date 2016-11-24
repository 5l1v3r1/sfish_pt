#
# (C) Tenable Network Security, Inc.
#

# Ref:
# From: "euronymous" <just-a-user@yandex.ru>
# To: vuln@security.nnov.ru, bugtraq@securityfocus.com
# Subject: ScozBook BETA 1.1 vulnerabilities


include("compat.inc");

if(description)
{
 script_id(11502);
 script_version ("$Revision: 1.14 $");
 script_cve_id("CVE-2003-1554", "CVE-2003-1555");
 script_bugtraq_id(7235, 7236);
 script_xref(name:"OSVDB", value:"43916");
 script_xref(name:"OSVDB", value:"43917");

 script_name(english: "ScozBook scozbook/add.php Multiple Parameter XSS");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web application is vulnerable to cross-site-scripting and 
path disclosure." );
 script_set_attribute(attribute:"description", value:
"The remote host is running ScozBook

This set of CGI has two vulnerabilities :

	- It is vulnerable to cross-site scripting attacks (in add.php)
	- If the user requests view.php with a crafted PG Variable, he 
          will obtain the physical path of the remote CGI
	
An attacker may use these flaws to steal the cookies of your users
or to gain better knowledge about this host." );
 script_set_attribute(attribute:"solution", value:
"Delete this package." );
 script_set_attribute(attribute:"cvss_vector", value:
"CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N" );
 script_end_attributes();

 script_summary(english: "Checks for the presence of view.php");
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
 script_family(english: "CGI abuses : XSS");
 script_dependencie("http_version.nasl");
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
if(!can_host_php(port:port))exit(0);

gdir = make_list(cgi_dirs());

dirs = make_list("", "/guestbook");
foreach d (gdir)
{
  dirs = make_list(dirs, string(d, "/guestbook"), d);
}


foreach dir (dirs)
{
 r = http_send_recv3(method: "GET", item:string(dir, "/view.php?PG=foobar"), port:port);
 if (isnull(r)) exit(0);

 if(egrep(pattern:".*MySQL result resource.*", string: r[2]))
 	{
	security_warning(port);
	set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
	exit(0);
	}
}
