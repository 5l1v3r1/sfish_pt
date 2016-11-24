#
# (C) 2003 StrongHoldNet
#
# Licence : GPL v2
#
# Modifications by rd:
#  -> Try every web server, not just port 81
#
# UNTESTED


include("compat.inc");

if (description)
{
 script_id(11707);
 script_version ("$Revision: 1.6 $");

 script_name(english:"Bugbear.B Web Backdoor Detection");

 script_set_attribute(attribute:"synopsis", value:
"The remote host is compromised." );
 script_set_attribute(attribute:"description", value:
"Your system seems to be infected by the Bugbear.B virus
(its backdoor has been detected on port 81)." );
 script_set_attribute(attribute:"see_also", value:"http://www.f-secure.com/v-descs/bugbear_b.shtml" );
 script_set_attribute(attribute:"solution", value:
"Use your favorite antivirus to disinfect your system. 
Standalone disinfection tools also exist :
ftp://ftp.f-secure.com/anti-virus/tools/f-bugbr.zip" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C" );
 script_end_attributes();

 script_summary(english:"Checks for Bugbear.B web backdoor");
 script_category(ACT_GATHER_INFO);
 script_family(english:"Backdoors");
 script_copyright(english:"This script is Copyright (C) 2003-2009 StrongHoldNet");
 script_dependencie("http_version.nasl");
 script_require_ports("Services/www", 81);
 exit(0);
}

include("http_func.inc");
include("http_keepalive.inc");

port = get_http_port(default:81);
if(!port)exit(0);

if(!get_port_state(port))exit(0);
url = '/%NETHOOD%/';
req = http_get(item:url, port:port);
buf = http_keepalive_send_recv(port:port, data:req);
if( buf == NULL ) exit(0);
if(ereg(pattern:"^HTTP/[0-9]\.[0-9] 200 ", string:buf) && "Microsoft Windows Network" >< buf) security_hole(port);

