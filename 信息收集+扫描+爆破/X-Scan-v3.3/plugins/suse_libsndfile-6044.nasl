
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(36080);
 script_version ("$Revision: 1.2 $");
 script_name(english: "SuSE Security Update:  libsndfile security update (libsndfile-6044)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch libsndfile-6044");
 script_set_attribute(attribute: "description", value: "Specially crafted CAF files could cause an integer overflow
in libsndfile (CVE-2009-0186).
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Install the security patch libsndfile-6044");
script_end_attributes();

script_cve_id("CVE-2009-0186");
script_summary(english: "Check for the libsndfile-6044 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"libsndfile-1.0.17-81.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libsndfile-32bit-1.0.17-81.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libsndfile-64bit-1.0.17-81.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libsndfile-devel-1.0.17-81.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libsndfile-octave-1.0.17-81.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libsndfile-progs-1.0.17-81.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
