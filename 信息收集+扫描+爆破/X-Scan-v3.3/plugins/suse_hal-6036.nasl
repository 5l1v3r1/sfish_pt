
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(41520);
 script_version ("$Revision: 1.1 $");
 script_name(english: "SuSE Security Update:  Security update for hal (hal-6036)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch hal-6036");
 script_set_attribute(attribute: "description", value: "The dbus package used a too permissive configuration.
Therefore intended access control for some services was not
applied (CVE-2008-4311).

The new configuration denies access by default. Some dbus
services may break due to this setting and need an updated
configuration as well.

Additionally a bug in hal that allowed users to crash the
hal daemon has been fixed.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch hal-6036");
script_end_attributes();

script_cve_id("CVE-2008-4311");
script_summary(english: "Check for the hal-6036 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");

if ( rpm_check( reference:"hal-0.5.6-33.41", release:"SLES10") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"hal-devel-0.5.6-33.41", release:"SLES10") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"hal-gnome-0.5.6-33.41", release:"SLES10") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
