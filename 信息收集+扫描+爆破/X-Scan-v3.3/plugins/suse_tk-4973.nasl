
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(31846);
 script_version ("$Revision: 1.2 $");
 script_name(english: "SuSE Security Update:  tk security update (tk-4973)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch tk-4973");
 script_set_attribute(attribute: "description", value: "Specially crafted GIF images could cause a buffer overflow
and crash tk. It seems unlikely but not entirely impossible
that this overflow can be exploited to execute arbitrary
code (CVE-2008-0553).
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch tk-4973");
script_end_attributes();

script_cve_id("CVE-2008-0553");
script_summary(english: "Check for the tk-4973 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"tk-8.4.15-25.3", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"tk-32bit-8.4.15-25.3", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"tk-64bit-8.4.15-25.3", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"tk-devel-8.4.15-25.3", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
