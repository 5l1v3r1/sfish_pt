#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(11096);
 script_version ("$Revision: 1.15 $");
 script_cve_id("CVE-2002-0134");
 script_bugtraq_id(3901);
 script_xref(name:"OSVDB", value:"6803");

 script_name(english:"Avirt Gateway Suite Telnet Proxy Arbitrary Command Execution");
 script_summary(english:"Remote system compromise through insecure telnet proxy");

 script_set_attribute(attribute:"synopsis", value:
"The remote gateway does not require authentication for connections to
the proxy service." );
 script_set_attribute(attribute:"description", value:
"It was possible to connect to the remote telnet server without a
password and to get a command prompt with the 'DOS' command.

And attacker may use this flaw to get access to your system." );
 script_set_attribute(attribute:"see_also", value:"http://marc.info/?l=bugtraq&m=101131669102843&w=2" );
 script_set_attribute(attribute:"solution", value:
"There is no known solution at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();
 
 script_category(ACT_ATTACK);
 
 script_copyright(english:"This script is Copyright (C) 2002-2009 Tenable Network Security, Inc.");
 script_family(english:"Gain a shell remotely");
 script_require_ports("Services/telnet", 23);
 script_dependencies("find_service1.nasl");
 exit(0);
}

#
# The script code starts here
#

include('telnet_func.inc');
port = get_kb_item("Services/telnet");
if(!port)port = 23;
if (!get_port_state(port))  exit(0);

soc = open_sock_tcp(port);
if (!soc) exit(0);

banner = telnet_negotiate(socket:soc);
cmd = string("dos\r\n");
send(socket:soc, data:cmd);
res = recv(socket: soc, length: 512);

close(soc);
flag = egrep(pattern:"^[A-Za-z]:\\.*>", string: res);
if (flag) security_hole(port);
