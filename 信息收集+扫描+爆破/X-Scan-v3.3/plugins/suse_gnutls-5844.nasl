
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(35080);
 script_version ("$Revision: 1.2 $");
 script_name(english: "SuSE Security Update:  gnutls security update (gnutls-5844)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch gnutls-5844");
 script_set_attribute(attribute: "description", value: "gnutls did not properly verify x509 certificate chains. An
attacker could exploit that to trick client programs into
trusting servers that would normally get rejected
(CVE-2008-4989).
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N");
script_set_attribute(attribute: "solution", value: "Install the security patch gnutls-5844");
script_end_attributes();

script_cve_id("CVE-2008-4989");
script_summary(english: "Check for the gnutls-5844 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"gnutls-1.6.1-36.4", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"gnutls-32bit-1.6.1-36.4", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"gnutls-64bit-1.6.1-36.4", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"gnutls-devel-1.6.1-36.4", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"gnutls-devel-32bit-1.6.1-36.4", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"gnutls-devel-64bit-1.6.1-36.4", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
