
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(41200);
 script_version("$Revision: 1.1 $");
 script_name(english: "SuSE9 Security Update:  Security update for ethereal (12098)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE9 system is missing the security patch 12098");
 script_set_attribute(attribute: "description", value: 'This update fixes the following bugs:
* the SCTP dissector could crash
* the SNMP dissector could crash
* the TFTP dissector could crash Wireshark (maybe a bug in
the Cairo library on specific platforms)
');
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "solution", value: "Install the security patch 12098");
script_end_attributes();

script_summary(english: "Check for the security advisory #12098");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"ethereal-0.10.13-2.32", release:"SUSE9", cpu: "i586") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
