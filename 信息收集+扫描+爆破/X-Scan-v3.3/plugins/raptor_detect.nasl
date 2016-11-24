#
# copyright 2001 by Holm Diening / SLITE IT-Security (holm.diening@slite.de)
#
# See the Nessus Scripts License for details
#

# Changes by Tenable:
# - Revised plugin title, enhanced script output (7/06/09)

include("compat.inc");

if(description)
{
 script_id(10730);
 script_version ("$Revision: 1.14 $");

 script_name(english:"Raptor Firewall 6.5 HTTP Proxy Detection");

 script_set_attribute(
  attribute:"synopsis",
  value:"A firewall / HTTP proxy is running in front of the remote web server."
 );
 script_set_attribute(
  attribute:"description",
  value:
"Raptor FW 6.5 appears to be running in front of the remote web
server.  By sending an invalid HTTP request to a web server behind
the Raptor firewall, the HTTP proxy itself will respond.  The server
banner of Raptor FW version 6.5 is always 'Simple, Secure Web Server
1.1'.  A remote attacker could use this information to mount further
attacks."
 );
 script_set_attribute(
  attribute:"solution",
  value:"Patch httpd / httpd.exe by hand."
 );
 script_set_attribute(
  attribute:"cvss_vector",
  value:"CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N"
 );
 script_end_attributes();

 script_summary(english:"Checks if the remote host is protected by Raptor FW 6.5");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2000-2009 Holm Diening");
 script_family(english:"Firewalls");
 script_require_ports("Services/www", 80);
 script_dependencies("find_service1.nasl");
 exit(0);
}

#
# The script code starts here
#
include("http_func.inc");
port = get_http_port(default:80);


if(get_port_state(port))
{
 socwww = open_sock_tcp(port);

 if (socwww)
  {
   teststring = string("some invalid request\r\n\r\n");
   testpattern = string("Simple, Secure Web Server 1.");
   send(socket:socwww, data:teststring);
   recv = http_recv(socket:socwww);
   if (testpattern >< recv)
   {
    security_warning(port);
    set_kb_item(name:"Services/www/" + port + "/embedded", value:TRUE);
   }
  close(socwww);
  }
 }
