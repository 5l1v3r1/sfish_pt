
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(28175);
 script_version ("$Revision: 1.3 $");
 script_name(english: "SuSE Security Update:  lcms: fixes errors while parsing ICC profiles in JPEG images (liblcms-4629)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch liblcms-4629");
 script_set_attribute(attribute: "description", value: "This update addresses security bugs in liblcms that
occurred while parsing ICC profiles in JPEG images.
(CVE-2007-2741) Remote attackers can exploit this bug to
execute arbitrary commands or cause denial-of-service.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Install the security patch liblcms-4629");
script_end_attributes();

script_cve_id("CVE-2007-2741");
script_summary(english: "Check for the liblcms-4629 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"liblcms-1.16-39.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"liblcms-32bit-1.16-39.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"liblcms-64bit-1.16-39.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"liblcms-devel-1.16-39.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"liblcms-devel-32bit-1.16-39.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"liblcms-devel-64bit-1.16-39.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
