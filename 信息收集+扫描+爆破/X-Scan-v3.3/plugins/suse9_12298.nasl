
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(41256);
 script_version("$Revision: 1.1 $");
 script_name(english: "SuSE9 Security Update:  Security update for net-snmp (12298)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE9 system is missing the security patch 12298");
 script_set_attribute(attribute: "description", value: 'Remote attackers could crash net-snmp via GETBULK-Request
(CVE-2008-4309).
In addition the following non-security issues have been fixed:
typo in error message (bnc#439857)
make OIDs longer than 256 chars work (bnc#345914)
typo in the snmpd init script to really load all agents
(bnc#415127)
logrotate config to restart the snmptrapd aswell (bnc#378069)
');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch 12298");
script_end_attributes();

script_cve_id("CVE-2008-4309");
script_summary(english: "Check for the security advisory #12298");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"net-snmp-5.1.3.1-0.24", release:"SUSE9", cpu: "i586") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"net-snmp-devel-5.1.3.1-0.24", release:"SUSE9", cpu: "i586") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"perl-SNMP-5.1.3.1-0.24", release:"SUSE9", cpu: "i586") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
