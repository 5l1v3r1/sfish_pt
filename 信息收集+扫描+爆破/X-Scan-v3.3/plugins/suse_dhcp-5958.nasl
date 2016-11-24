
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(35715);
 script_version ("$Revision: 1.2 $");
 script_name(english: "SuSE Security Update:  dhcp: denial of service (dhcp-5958)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch dhcp-5958");
 script_set_attribute(attribute: "description", value: "This update contains a backported patch from dhcp-3.0.7 to
fix a buffer overflow which could lead to a
denial-of-service condition in cases when the dhcp server
is configured to send many DHCP options to clients.
(CVE-2007-0062)
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Install the security patch dhcp-5958");
script_end_attributes();

script_cve_id("CVE-2007-0062");
script_summary(english: "Check for the dhcp-5958 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"dhcp-3.0.6-24.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"dhcp-client-3.0.6-24.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"dhcp-devel-3.0.6-24.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"dhcp-relay-3.0.6-24.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"dhcp-server-3.0.6-24.2", release:"SUSE10.3") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
