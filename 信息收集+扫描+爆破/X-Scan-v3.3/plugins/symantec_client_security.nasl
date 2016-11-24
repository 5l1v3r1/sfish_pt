#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
 script_id(22419);
 script_version("$Revision: 1.4 $");

 script_name(english:"Symantec SAVCE/Client Security Service Detection");
 script_summary(english:"Checks for Symantec SAVCE/Client Security service");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is running an Antivirus." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Symantec Antivirus Agent, a 
real time embedded service used by Symantec SAVCE and Client
Security." );
 script_set_attribute(attribute:"risk_factor", value:"None" );
 script_set_attribute(attribute:"solution", value:"n/a" );
script_end_attributes();

 
 script_category(ACT_GATHER_INFO);
 script_family(english:"Service detection");
 
 script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");

 script_dependencies("find_service2.nasl");
 script_require_ports(2967);

 exit(0);
}

include ("global_settings.inc");
include ("misc_func.inc");

port = 2967;

soc = open_sock_tcp (port);
if (!soc)
  exit (0);

req = '\x01\x10\x00\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00' ;
rep = '\x01\x10\x00\x00\x14\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00' ;

send (socket:soc, data:req);
buf = recv (socket:soc, length:strlen(rep));

if (buf == rep)
{
 register_service(port: port, proto: "savce");
 security_note (port);
}

