
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(27172);
 script_version ("$Revision: 1.5 $");
 script_name(english: "SuSE Security Update:  chmlib: Security Update to fix code execution (chmlib-2595)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch chmlib-2595");
 script_set_attribute(attribute: "description", value: "This update of chmlib fixes a vulnerability that allowed
the execution of arbitrary code. CVE-2007-0619
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Install the security patch chmlib-2595");
script_end_attributes();

script_cve_id("CVE-2007-0619");
script_summary(english: "Check for the chmlib-2595 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"chmlib-0.39-1.2", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"chmlib-devel-0.39-1.2", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
