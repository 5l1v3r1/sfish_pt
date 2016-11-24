#
# This script was written by Michel Arboi <mikhail@nessus.org>
#


include("compat.inc");

if(description)
{
 script_id(20160);
 script_version ("$Revision: 1.7 $");
 script_name(english: "Cheops NG Agent Detection");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is running a network management tool." );
 script_set_attribute(attribute:"description", value:
"The remote host is running a Cheops NG agent.  Cheops NG is an
open-source network management tool, and the cheops-agent provides a
way for remote hosts to communicate with the tool and use it to map
your network, port scan machines and identify running services." );
 script_set_attribute(attribute:"see_also", value:"http://cheops-ng.sourceforge.net/" );
 script_set_attribute(attribute:"risk_factor", value:"None" );
 script_set_attribute(attribute:"solution", value:"n/a" );

script_end_attributes();

 script_summary(english: "Cheops NG agent is running");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 script_family(english: "Service detection");
 script_dependencie("find_service1.nasl", "find_service2.nasl");
 script_require_ports(2300, "Services/unknown");
 exit(0);
}

include("global_settings.inc");
include("misc_func.inc");

m1 = '\x00\x00\x00\x14\x00\x0c\x00\x04\x00\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00';
m2 = '\x00\x00\x00\x20\x00\x0c\x00\x02\x00\x00\x00\x00\x01\x00\x00\x7f\x01\x00\x00\x7f\x00\x00\x00\x00\x00\x00\x00\x00\xb8\xdf\x0d\x08';

if (thorough_tests && ! get_kb_item("global_settings/disable_service_discovery")  )
 ports = get_kb_list("Services/unknown");
else
 ports = NULL;
ports = add_port_in_list(list: ports, port: 2300);

prev = 0;
foreach port (ports)
{
 if (port && port != prev && get_port_state(port) && service_is_unknown(port:port) && port != 135 && port != 139 && port != 445 )
 {
  prev = port;
  soc = open_sock_tcp(port);
  if (soc)
  {
   send(socket: soc, data: m1);
   r = recv(socket: soc, length: 512);
   if (strlen(r) > 0)
   {
    debug_print('Service on port ', port, ' answers to first request - L=', strlen(r), '\n');
    if (substr(r, 0, 7) == '\x00\x00\x00\x10\x00\x0c\x00\x6c')
    {
     security_note(port: port);
     register_service(port: port, proto: 'cheops-ng');
     set_kb_item(name: 'cheopsNG/password', value: port);
    }
    close(soc);
    continue;
   }
   send(socket: soc, data: m2);
   r = recv(socket: soc, length: 512);
   l = strlen(r);
   debug_print('reply length = ', l, '\n');
   if (l >= 8 && substr(r, 0, 2) == '\0\0\0' && '\x01\x00\x00\x7f' >< r)
   {
    security_note(port);
    register_service(port: port, proto: 'cheops-ng');
     set_kb_item(name: 'cheopsNG/unprotected', value: port);
   }
   close(soc);
  }
 }
}
