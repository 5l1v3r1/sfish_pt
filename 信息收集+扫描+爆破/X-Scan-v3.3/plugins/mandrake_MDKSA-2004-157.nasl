
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(16038);
 script_version ("$Revision: 1.4 $");
 script_name(english: "MDKSA-2004:157: mplayer");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2004:157 (mplayer).");
 script_set_attribute(attribute: "description", value: "A number of vulnerabilities were discovered in the MPlayer program by
iDEFENSE, Ariel Berkman, and the MPlayer development team. These
vulnerabilities include potential heap overflows in Real RTSP and pnm
streaming code, stack overflows in MMST streaming code, and multiple
buffer overflows in the BMP demuxer and mp3lib code.
The updated packages have been patched to prevent these problems.
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2004:157");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_summary(english: "Check for the version of the mplayer package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"libdha0.1-1.0-0.pre3.14.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libpostproc0-1.0-0.pre3.14.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libpostproc0-devel-1.0-0.pre3.14.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mencoder-1.0-0.pre3.14.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mplayer-1.0-0.pre3.14.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mplayer-gui-1.0-0.pre3.14.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libdha1.0-1.0-0.pre5.7.101mdk", release:"MDK10.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libpostproc0-1.0-0.pre5.7.101mdk", release:"MDK10.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"libpostproc0-devel-1.0-0.pre5.7.101mdk", release:"MDK10.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mencoder-1.0-0.pre5.7.101mdk", release:"MDK10.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mplayer-1.0-0.pre5.7.101mdk", release:"MDK10.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mplayer-gui-1.0-0.pre5.7.101mdk", release:"MDK10.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
