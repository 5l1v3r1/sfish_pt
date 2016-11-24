
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if (NASL_LEVEL < 3000 ) exit(0);

if(description)
{
 script_id(42003);
 script_version ("$Revision: 1.1 $");
 script_name(english: "SuSE Security Update:  gstreamer010-plugins-bad: libmodplug 's3m' remote buffer overflow vulnerability (gstreamer010-plugins-bad-6251)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch gstreamer010-plugins-bad-6251");
 script_set_attribute(attribute: "description", value: "This update fixes a buffer overflow in libmodplug that can
be exploited remotely to execute arbitrary code with the
privileges of the process using the libaray. (CVE-2009-1438)
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch gstreamer010-plugins-bad-6251");
script_end_attributes();

script_cve_id("CVE-2009-1438");
script_summary(english: "Check for the gstreamer010-plugins-bad-6251 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"gstreamer010-plugins-bad-0.10.5-36.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"gstreamer010-plugins-bad-devel-0.10.5-36.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"gstreamer010-plugins-bad-doc-0.10.5-36.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
