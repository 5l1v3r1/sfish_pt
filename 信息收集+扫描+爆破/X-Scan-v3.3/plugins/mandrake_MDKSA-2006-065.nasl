
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(21200);
 script_version ("$Revision: 1.3 $");
 script_name(english: "MDKSA-2006:065: kaffeine");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2006:065 (kaffeine).");
 script_set_attribute(attribute: "description", value: "Marcus Meissner discovered Kaffeine contains an unchecked buffer while
creating HTTP request headers for fetching remote RAM playlists, which
allows overflowing a heap allocated buffer. As a result, remotely
supplied RAM playlists can be used to execute arbitrary code on the
client machine.
Updated packages have been patched to correct this issue.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2006:065");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2006-0051");
script_summary(english: "Check for the version of the kaffeine package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"kaffeine-0.7-6.1.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libkaffeine0-0.7-6.1.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libkaffeine0-devel-0.7-6.1.20060mdk", release:"MDK2006.0", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"kaffeine-", release:"MDK2006.0") )
{
 set_kb_item(name:"CVE-2006-0051", value:TRUE);
}
exit(0, "Host is not affected");
