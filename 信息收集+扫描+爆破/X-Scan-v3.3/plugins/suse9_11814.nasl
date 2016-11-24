
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(41154);
 script_version("$Revision: 1.1 $");
 script_name(english: "SuSE9 Security Update:  Security update for fetchmail (11814)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE9 system is missing the security patch 11814");
 script_set_attribute(attribute: "description", value: 'This update fixes a remote denial-of-service attack.
(CVE-2007-4565)
');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch 11814");
script_end_attributes();

script_cve_id("CVE-2007-4565");
script_summary(english: "Check for the security advisory #11814");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"fetchmail-6.2.5-49.17", release:"SUSE9", cpu: "i586") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"fetchmailconf-6.2.5-49.17", release:"SUSE9", cpu: "i586") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
