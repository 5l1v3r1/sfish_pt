#
# This script was written by Forrest Rae <forrest.rae@digitaldefense.net>
# 

include("compat.inc");

if(description)
{
	script_id(11208);
	script_version("$Revision: 1.13 $");
	script_cve_id("CVE-1999-0502");
	script_xref(name:"OSVDB", value:"876");

	script_name(english:"Netscape Enterprise Default Administrative Password");
	script_summary(english:"Netscape Enterprise Default Administrative Password");

	script_set_attribute(attribute:"synopsis", value:
"The remote web server uses a default set of administrative
credentials.");
	script_set_attribute(attribute:"description", value:
"This host is running Netscape Enterprise Server.  The administrative
interface for this web server is using the default username and
password of 'admin'.  An attacker can use this to reconfigure the web
server, cause a denial of service condition, or gain access to this
host.");
	script_set_attribute(attribute:"solution", value:
"Please assign the web administration console a difficult to guess
password.");
	script_set_attribute(attribute:"cvss_vector", value:
"CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
	script_set_attribute(attribute:"plugin_publication_date", value:
"2003/01/22");
	script_end_attributes();

	script_category(ACT_GATHER_INFO);
	script_copyright(english:"This script is Copyright (C) 2003-2009 Digital Defense Inc.");
	script_family(english:"CGI abuses");
	script_require_ports("Services/www", 8888);
	script_dependencies("find_service1.nasl");
	exit(0);
}

#
# The script code starts here
#
include("http_func.inc");
include("misc_func.inc");

debug = 0;

ports = add_port_in_list(list:get_kb_list("Services/www"), port:8888);

foreach port (ports)
{
	if ( !get_port_state(port) ) continue;
	banner = get_http_banner(port:port);
	if ( ! banner || ("Netscape" >!< banner && "iPlanet" >!< banner ) ) continue;
	soc = http_open_socket(port);
	
	if (soc)
	{
		
		# HTTP auth = "admin:admin"
		
		
		req = http_get(item:"/https-admserv/bin/index", port:port);
    		req = req - string("\r\n\r\n");
    		req = string(req, "\r\nAuthorization: Basic YWRtaW46YWRtaW4=\r\n\r\n");
    
		
		send(socket:soc, data:req);
		buf = http_recv(socket:soc);
		http_close_socket(soc);
		if (isnull(buf)) continue;
		
		if(debug == 1) display("\n\n", buf, "\n\n");
		
		
		if (("Web Server Administration Server" >< buf) && ("index?tabs" >< buf))
		{
			security_hole(port:port);
		}
	}
}
