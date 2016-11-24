#
# This NASL script has been produced as a collaboration between:
#
# - Martin O'Neal of Corsaire (http://www.corsaire.com)  
# - Jakob Bohm of Danware (http://www.danware.dk)
# 
# DISCLAIMER
# The information contained within this script is supplied "as-is" with 
# no warranties or guarantees of fitness of use or otherwise. Neither Corsaire 
# or Danware accept any responsibility for any damage caused by the use or misuse 
# of this information.
# 

# Changes by Tenable:
# - Revised plugin title, touched up copyright, added OSVDB ref (1/21/09)
# - Changed family (8/21/09)

############## description ################

# declare description

include("compat.inc");

if(description)
{
	script_id(15767);
	script_version ('$Revision: 1.7 $');
	script_cve_id("CVE-2004-0950");
	script_bugtraq_id(11710);
	script_xref(name:"OSVDB", value:"11993");

	script_name(english:"Danware NetOp Host HELO Request Remote Information Disclosure");

 script_set_attribute(attribute:"synopsis", value:
"Basic information about the remote host can be read." );
 script_set_attribute(attribute:"description", value:
"This script simply displays the basic name and address information 
provided by NetOp products for easy network browsing and reminds admins 
to turn off that information if they don't want it to be visible.

The script also provides program-specific instructions for doing so 
depending on the actual product detected" );
 script_set_attribute(attribute:"solution", value:
"Turn off that information." );
 script_set_attribute(attribute:"risk_factor", value:"Low" );
script_end_attributes();

	script_summary(english:"Detect if a NetOp product is configured to make the host name, IP address etc. public");
	script_category(ACT_GATHER_INFO);
	script_copyright(english:"(C) Copyright 2004-2009 Corsaire Limited and Danware Data A/S.");
	script_family(english: "Misc.");
	script_dependencies('netop_detect_udp.nasl', 'netop_detect_tcp.nasl');

	exit(0);
}



############## declarations ################

# includes
include('netop.inc');

function named_items(nam, typ)
{
	local_var v1;
	v1 = netop_banner_items(typ:typ);
	if (v1 != '' && nam != '')
		v1 = nam + ': ' + v1;
	if (v1 != '')
		v1 = v1 + '\n';
	return v1;
}



############## script ################

# Check knowledgabase and fork if multiple entries
if (netop_each_found())
{
	local_var vals;
	vals    = '';
	
	vals += named_items(nam:'host', typ:0);
	vals += named_items(nam:'user', typ:9);
	vals += named_items(nam:'', typ:8);
	vals += named_items(nam:'', typ:17);
	vals += named_items(nam:'', typ:4);
	vals += named_items(nam:'', typ:1);
	if (((ord(netop_kb_val[63]) & 0x01) == 1) || (vals != '') || eregmatch(pattern:"([^12]10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[0-1])\.[0-9]{1,3}\.[0-9]{1,3}|192\.168\.[0-9]{1,3}\.[0-9]{1,3})", string:named_items(nam:'address', typ:2)))  vals += named_items(nam:'address', typ:2);
	
	if (vals != '')
	{
		if (netop_prod_typ[0] == 'RGST')
		{
			vals =
'\nDanware ' + netop_prod_nam + ' information disclosure.\n\n' +
'The following information is made publicly visible for use by NetOp host
programs requesting help:\n\n'+ vals + '\n' +
'You can control access to this information by removing help services from
the program options or by reducing the set of preinitialized communication
profiles\n\n';
		}
		else if (netop_prod_typ[0] != 'S')
		{
			vals =
'\nDanware ' + netop_prod_nam + ' information disclosure.\n\n' +
'The following information is made publicly visible for easy network
browsing from NetOp Guest:\n\n' + vals + '\n' +
'
If using a version of the software prior to 7.65 build 2004278, 
then it is necessary to upgrade to correct this issue. 
Simply use the built-in WebUpdate feature or download the update from 
http://www.netop.com.

For all other versions, you can turn this feature off by unchecking the
"Public Host Name" check box in the program options (on the host name 
tab) and restarting the communication layer from the action menu or 
toolbar.

Additional information is available from 
http://www.corsaire.com/advisories/c040619-001.txt\n';
		}
		else
		{
			vals =
'\nDanware ' + netop_prod_nam + ' information disclosure.\n\n' +
'The following information is made publicly visible on the classroom
network so the Teacher and Student can see each other in the class:\n\n' +
vals + '\n' +
'If this information is visible from outside the schools network, you 
should reconfigure your firewall to limit access to this port to those
students and teachers who are participating from their homes etc.\n\n';
		}
		
		security_note(proto: proto_nam, port: port, extra: vals);
	}
}

exit(0);

############## End of published info specific detection script ################
