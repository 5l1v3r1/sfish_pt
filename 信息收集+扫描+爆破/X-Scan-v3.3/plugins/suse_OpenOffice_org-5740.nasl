
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(34844);
 script_version ("$Revision: 1.5 $");
 script_name(english: "SuSE Security Update:  Security update for OpenOffice_org (OpenOffice_org-5740)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch OpenOffice_org-5740");
 script_set_attribute(attribute: "description", value: "This update fixes an integer overflow in the WMF handler
(CVE-2008-2237) and multiple bugs in the EMF parser
(CVE-2008-2238). Additionally multiple non-security bugs
were fixed.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Install the security patch OpenOffice_org-5740");
script_end_attributes();

script_cve_id("CVE-2008-2237", "CVE-2008-2238");
script_summary(english: "Check for the OpenOffice_org-5740 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");

if ( rpm_check( reference:"OpenOffice_org-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-af-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-ar-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-ca-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-cs-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-da-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-de-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-es-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-fi-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-fr-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-galleries-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-gnome-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-gu-IN-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-hi-IN-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-hu-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-it-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-ja-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-kde-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-mono-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-nb-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-nl-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-nld-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-nn-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-pl-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-pt-BR-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-ru-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-sk-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-sv-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-xh-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-zh-CN-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-zh-TW-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"OpenOffice_org-zu-2.4.1-0.8", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
