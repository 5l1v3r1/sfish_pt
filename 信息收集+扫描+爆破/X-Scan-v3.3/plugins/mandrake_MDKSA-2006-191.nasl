
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(24576);
 script_version ("$Revision: 1.3 $");
 script_name(english: "MDKSA-2006:191: screen");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2006:191 (screen).");
 script_set_attribute(attribute: "description", value: "Multiple unspecified vulnerabilities in the 'utf8 combining characters
handling' (utf8_handle_comb function in encoding.c) in screen before
4.0.3 allows user-assisted attackers to cause a denial of service
(crash or hang) via certain UTF8 sequences.
Updated packages have been patched to correct this issue.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2006:191");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2006-4573");
script_summary(english: "Check for the version of the screen package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"screen-4.0.2-6.1.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_note(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"screen-4.0.2-9.1mdv2007.0", release:"MDK2007.0", yank:"mdv") )
{
 security_note(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"screen-", release:"MDK2006.0")
 || rpm_exists(rpm:"screen-", release:"MDK2007.0") )
{
 set_kb_item(name:"CVE-2006-4573", value:TRUE);
}
exit(0, "Host is not affected");
