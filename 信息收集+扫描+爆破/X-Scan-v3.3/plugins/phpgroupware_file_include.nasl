#
# (C) Tenable Network Security
#

# Ref: 
# Date: 22 Jul 2003 15:05:29 -0000
# From: phil dunn <z3hp@yahoo.com>
# To: bugtraq@securityfocus.com
# Subject: sorry, wrong file


include("compat.inc");

if(description)
{
 script_id(11799);
 script_version ("$Revision: 1.19 $");

 script_cve_id("CVE-2006-0524", "CVE-2003-1292");
 script_bugtraq_id(8241, 16426);
 script_xref(name:"OSVDB", value:"22934");
 script_xref(name:"OSVDB", value:"22912");

 script_name(english:"ashNews 0.83 Multiple Vulnerabilities");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is affected by
multiple vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"It is possible to make the remote host include php files hosted on a
third party server using Ashnews. 

An attacker may use this flaw to inject arbitrary code in the remote
host and gain a shell with the privileges of the web server. 

In addition, the application reportedly fails to sanitize the 'id'
parameter before using it in dynamically-generated output, subjecting
users to cross-site scripting attacks." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/329910" );
 script_set_attribute(attribute:"see_also", value:"http://lists.grok.org.uk/pipermail/full-disclosure/2006-January/041844.html" );
 script_set_attribute(attribute:"solution", value:
"Remove the software as it is no longer supported." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N" );

script_end_attributes();

 
 script_summary(english:"Checks for the presence of ashnews.php");
 
 script_category(ACT_ATTACK);
 
 script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
 
 script_family(english:"CGI abuses");
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


# Loop through CGI directories.
foreach loc (cgi_dirs()) {
  w = http_send_recv3(method: "GET", item:string(loc, "/ashnews.php?pathtoashnews=http://xxxxxxxx/"), port:port);
  if (isnull(w)) exit(0);
  r = strcat(w[0], w[1], '\r\n', w[2]);

  if(egrep(pattern:".*http://xxxxxxxx/ashprojects/newsconfig\.php", string:r))
  {
   	security_warning(port);
	set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
  }
}
