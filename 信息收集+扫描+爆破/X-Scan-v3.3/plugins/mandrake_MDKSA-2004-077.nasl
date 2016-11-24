
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(14175);
 script_version ("$Revision: 1.7 $");
 script_name(english: "MDKSA-2004:077: wv");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2004:077 (wv).");
 script_set_attribute(attribute: "description", value: "iDefense discovered a buffer overflow vulnerability in the wv package
which could allow an attacker to execute arbitrary code with the
privileges of the user running the vulnerable application.
The updated packages are patched to protect against this problem.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2004:077");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2004-0645");
script_summary(english: "Check for the version of the wv package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"libwv-1.0_0-1.0.0-1.1.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libwv-1.0_0-devel-1.0.0-1.1.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"wv-1.0.0-1.1.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libwv-1.0_0-1.0.0-1.1.92mdk", release:"MDK9.2", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libwv-1.0_0-devel-1.0.0-1.1.92mdk", release:"MDK9.2", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"wv-1.0.0-1.1.92mdk", release:"MDK9.2", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"wv-", release:"MDK10.0")
 || rpm_exists(rpm:"wv-", release:"MDK9.2") )
{
 set_kb_item(name:"CVE-2004-0645", value:TRUE);
}
exit(0, "Host is not affected");
