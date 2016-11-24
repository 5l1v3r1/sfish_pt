
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(18584);
 script_version ("$Revision: 1.5 $");
 script_name(english: "MDKSA-2005:107: ImageMagick");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2005:107 (ImageMagick).");
 script_set_attribute(attribute: "description", value: "A heap-based buffer overflow was found in the way that ImageMagick
parses PNM files. If an attacker can trick a victim into opening
a specially crafted PNM file, the attacker could execute arbitrary
code on the victim's machine (CVE-2005-1275).
As well, a Denial of Service vulnerability was found in the way
that ImageMagick parses XWD files. If a user or program executed
ImageMagick to process a malicious XWD file, ImageMagick will enter
info an infinite loop causing a DoS (CVE-2005-1739).
The updated packages have been patched to fix these issues.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2005:107");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2005-1275", "CVE-2005-1739");
script_summary(english: "Check for the version of the ImageMagick package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"ImageMagick-6.0.4.4-5.3.101mdk", release:"MDK10.1", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"ImageMagick-doc-6.0.4.4-5.3.101mdk", release:"MDK10.1", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libMagick6.4.0-6.0.4.4-5.3.101mdk", release:"MDK10.1", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libMagick6.4.0-devel-6.0.4.4-5.3.101mdk", release:"MDK10.1", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"perl-Magick-6.0.4.4-5.3.101mdk", release:"MDK10.1", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"ImageMagick-6.2.0.3-8.1.102mdk", release:"MDK10.2", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"ImageMagick-doc-6.2.0.3-8.1.102mdk", release:"MDK10.2", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libMagick8.0.2-6.2.0.3-8.1.102mdk", release:"MDK10.2", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libMagick8.0.2-devel-6.2.0.3-8.1.102mdk", release:"MDK10.2", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"perl-Image-Magick-6.2.0.3-8.1.102mdk", release:"MDK10.2", yank:"mdk") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"ImageMagick-", release:"MDK10.1")
 || rpm_exists(rpm:"ImageMagick-", release:"MDK10.2") )
{
 set_kb_item(name:"CVE-2005-1275", value:TRUE);
 set_kb_item(name:"CVE-2005-1739", value:TRUE);
}
exit(0, "Host is not affected");
