#
# (C) Tenable Network Security
#


include("compat.inc");

if(description)
{
 script_id(11938);
 script_version("$Revision: 1.14 $");

 script_cve_id("CVE-2003-1215", "CVE-2003-1216");
 script_bugtraq_id(9122, 9314);
 script_xref(name:"OSVDB", value:"2875");
 script_xref(name:"OSVDB", value:"3302");
 
 script_name(english:"phpBB < 2.0.7 Multiple Script SQL Injection");
 
 script_set_attribute(attribute:"synopsis", value:
"A remote web application is vulnerable to SQL injection." );
 script_set_attribute(attribute:"description", value:
"The remote host is running a version of phpBB older than 2.0.7.

There is a flaw in the remote software which may allow anyone to inject
arbitrary SQL commands, which may in turn be used to gain administrative
access on the remote host or to obtain the MD5 hash of the password of 
any user." );
 script_set_attribute(attribute:"solution", value:
"Upgrade to version 2.0.7 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();

 
 script_summary(english:"SQL Injection");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
 script_family(english:"CGI abuses");
 script_dependencie("phpbb_detect.nasl");
 script_require_ports("Services/www", 80);
 exit(0);
}

# Check starts here
include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80);

kb = get_kb_item("www/" + port + "/phpBB");
if ( ! kb ) exit(0);

matches = eregmatch(pattern:"(.*) under (.*)", string:kb);
version = matches[1];
if ( ereg(pattern:"^([01]\..*|2\.0\.[0-6]([^0-9]|$))", string:version) )
{
	security_hole ( port );
  set_kb_item(name: 'www/'+port+'/SQLInjection', value: TRUE);
}

