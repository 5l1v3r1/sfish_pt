#
# This script was written by John Lampe...j_lampe@bellsouth.net 
#
# See the Nessus Scripts License for details
#
# Changes by Tenable:
# - Revised plugin title (12/23/2008)


include("compat.inc");

if(description)
{
 script_id(11727);
 script_bugtraq_id(4093);
 script_version ("$Revision: 1.12 $");
 script_cve_id("CVE-2002-0273");
 script_xref(name:"OSVDB", value:"14343");
 
 name["english"] = "NetWin CWmail.exe Item Parameter Remote Overflow";
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web-mail server is affected by a remote buffer 
vulnerability." );
 script_set_attribute(attribute:"description", value:
"The CWMail.exe exists on this webserver.  Some versions of this file
are vulnerable to remote exploit.

An attacker may make use of this file to gain access to confidential
data or escalate their privileges on the Web server." );
 script_set_attribute(attribute:"see_also", value:"http://marc.info/?l=bugtraq&m=101362100602008&w=2" );
 script_set_attribute(attribute:"solution", value:
"Contact your vendor for a patch." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:L/AC:L/Au:N/C:P/I:P/A:P" );


script_end_attributes();

 
 summary["english"] = "Checks for the cwmail.exe file";
 
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2003-2009 John Lampe");
 family["english"] = "CGI abuses";
 script_family(english:family["english"]);
 script_dependencie("http_version.nasl", "find_service1.nasl", "no404.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

#
# The script code starts here
#

include("http_func.inc");
include("http_keepalive.inc");

port = get_http_port(default:80);

if(!get_port_state(port))exit(0);


foreach dir (cgi_dirs()) {
   req = http_get(item:dir + "/cwmail.exe", port:port);
   res = http_keepalive_send_recv(port:port, data:req);
   if( res == NULL ) exit(0);
   
   if (egrep (pattern:".*CWMail 2\.[0-7]\..*", string:res) ) {
   	security_warning(port);
	exit(0);
	}
}
