
#
# (C) Tenable Network Security, Inc.
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(41355);
 script_version("$Revision: 1.1 $");
 script_name(english: "SuSE Security Update:  MozillaFirefox (2009-05-07)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing a security patch for MozillaFirefox");
 script_set_attribute(attribute: "description", value: "Firefox version upgrade to 3.0.10 to fix a crash in
nsTextFrame::ClearTextRun() (CVE-2009-1313).
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Run yast to install the security patch for MozillaFirefox");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=500909");
script_end_attributes();

 script_cve_id("CVE-2009-1313");
script_summary(english: "Check for the MozillaFirefox package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"MozillaFirefox-3.0.10-1.1.1", release:"SLES11", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"MozillaFirefox-translations-3.0.10-1.1.1", release:"SLES11", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"mozilla-xulrunner190-1.9.0.10-1.1.1", release:"SLES11", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"mozilla-xulrunner190-gnomevfs-1.9.0.10-1.1.1", release:"SLES11", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"mozilla-xulrunner190-translations-1.9.0.10-1.1.1", release:"SLES11", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"MozillaFirefox-3.0.10-1.1.1", release:"SLED11", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"MozillaFirefox-translations-3.0.10-1.1.1", release:"SLED11", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"mozilla-xulrunner190-1.9.0.10-1.1.1", release:"SLED11", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"mozilla-xulrunner190-gnomevfs-1.9.0.10-1.1.1", release:"SLED11", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"mozilla-xulrunner190-translations-1.9.0.10-1.1.1", release:"SLED11", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
