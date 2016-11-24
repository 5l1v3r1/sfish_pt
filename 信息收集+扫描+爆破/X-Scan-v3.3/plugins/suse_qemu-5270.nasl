
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(33163);
 script_version ("$Revision: 1.2 $");
 script_name(english: "SuSE Security Update:  qemu: fixed CVE-2008-2004 (qemu-5270)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch qemu-5270");
 script_set_attribute(attribute: "description", value: "Local attackers could use raw formatted disk images to
access the hosting environment. CVE-2008-2004 has been
assigned to this issue.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:L/Au:N/C:C/I:N/A:N");
script_set_attribute(attribute: "solution", value: "Install the security patch qemu-5270");
script_end_attributes();

script_cve_id("CVE-2008-2004");
script_summary(english: "Check for the qemu-5270 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"qemu-0.9.0.cvs-35.2", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
