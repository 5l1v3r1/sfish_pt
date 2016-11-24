#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(19763);
 script_version ("$Revision: 1.16 $");
 
 script_name(english:"SNMP Query Installed Software Disclosure");
 
 script_set_attribute(attribute:"synopsis", value:
"The list of software installed on the remote host can be obtained via
SNMP." );
 script_set_attribute(attribute:"description", value:
"It is possible to obtain the list of installed software on the remote
host by sending SNMP requests with the OID 1.3.6.1.2.1.25.6.3.1.2

An attacker may use this information to gain more knowledge about the
target host." );
 script_set_attribute(attribute:"solution", value:
"Disable the SNMP service on the remote host if you do not use it, or
filter incoming UDP packets going to this port." );
 script_set_attribute(attribute:"risk_factor", value:"None" );
script_end_attributes();

 script_summary(english:"Enumerates software via SNMP");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 script_family(english:"SNMP");
 script_dependencies("snmp_settings.nasl", "find_service2.nasl");
 script_require_keys("SNMP/community");
 exit(0);
}

include ("misc_func.inc");
include ("snmp_func.inc");

community = get_kb_item("SNMP/community");
if(!community)exit(0);

port = get_kb_item("SNMP/port");
if(!port)port = 161;

soc = open_sock_udp(port);
if (!soc)
  exit (0);

soft = scan_snmp_string (socket:soc, community:community, oid:"1.3.6.1.2.1.25.6.3.1.2");

if(strlen(soft))
{
 report = string ("\n", soft);
 set_kb_item(name: "SNMP/hrSWInstalledName", value: soft);
 security_note(port:port, extra:report, protocol:"udp");
}
