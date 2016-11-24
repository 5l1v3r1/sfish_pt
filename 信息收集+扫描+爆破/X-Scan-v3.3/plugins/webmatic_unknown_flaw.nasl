#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(14382);
 script_version("$Revision: 1.11 $");
 script_bugtraq_id(11045);
 script_xref(name:"OSVDB", value:"7092");
 
 script_name(english:"WebMatic Unspecified Login Function Access Vulnerability");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains an application that is prone to an
unknown vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host is running WebMatic, a web-based application designed
to generate websites. 

The vendor has released WebMatic 1.9 to address an unknown flaw in
earlier versions of the software." );
 script_set_attribute(attribute:"solution", value:
"Upgrade to WebMatic 1.9 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();

 script_summary(english:"Checks the version of WebMatic");
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
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

foreach dir ( cgi_dirs() )
{
 res = http_get_cache(item:string(dir, "/index.php"), port:port);
 if ( res == NULL ) exit(0);

 #<a href="http://www.webmatic.tk" TARGET="NEW">Powered by: Webmatic 1.9</a></div></td>
 if ( "Webmatic" >< res && 
      egrep(pattern:"<a href=[^>]+>Powered by: Webmatic (0\.|1\.[0-8][^0-9])", string:res) )
	{
	security_hole( port );
	exit(0);
 	}
}
