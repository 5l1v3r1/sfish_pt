
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandriva Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(36438);
 script_version ("$Revision: 1.1 $");
 script_name(english: "MDVSA-2008:102: libvorbis");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDVSA-2008:102 (libvorbis).");
 script_set_attribute(attribute: "description", value: "Will Drewry of the Google Security Team reported several
vulnerabilities in how libvorbis processed audio data. An attacker
could create a carefuly crafted OGG audio file in such a way that it
would cause an application linked to libvorbis to crash or possibly
execute arbitray code when opened (CVE-2008-1419, CVE-2008-1420,
CVE-2008-1423).
The updated packages have been patched to correct these issues.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDVSA-2008:102");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2008-1419", "CVE-2008-1420", "CVE-2008-1423");
script_summary(english: "Check for the version of the libvorbis package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"libvorbis0-1.1.2-1.4mdv2007.1", release:"MDK2007.1", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libvorbis0-devel-1.1.2-1.4mdv2007.1", release:"MDK2007.1", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libvorbisenc2-1.1.2-1.4mdv2007.1", release:"MDK2007.1", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libvorbisfile3-1.1.2-1.4mdv2007.1", release:"MDK2007.1", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libvorbis0-1.2.0-1.1mdv2008.0", release:"MDK2008.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libvorbis-devel-1.2.0-1.1mdv2008.0", release:"MDK2008.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libvorbisenc2-1.2.0-1.1mdv2008.0", release:"MDK2008.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libvorbisfile3-1.2.0-1.1mdv2008.0", release:"MDK2008.0", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libvorbis0-1.2.0-3.1mdv2008.1", release:"MDK2008.1", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libvorbis-devel-1.2.0-3.1mdv2008.1", release:"MDK2008.1", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libvorbisenc2-1.2.0-3.1mdv2008.1", release:"MDK2008.1", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libvorbisfile3-1.2.0-3.1mdv2008.1", release:"MDK2008.1", yank:"mdv") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"libvorbis-", release:"MDK2007.1")
 || rpm_exists(rpm:"libvorbis-", release:"MDK2008.0")
 || rpm_exists(rpm:"libvorbis-", release:"MDK2008.1") )
{
 set_kb_item(name:"CVE-2008-1419", value:TRUE);
 set_kb_item(name:"CVE-2008-1420", value:TRUE);
 set_kb_item(name:"CVE-2008-1423", value:TRUE);
}
exit(0, "Host is not affected");
