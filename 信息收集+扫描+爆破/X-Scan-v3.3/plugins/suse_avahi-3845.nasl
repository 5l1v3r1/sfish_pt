
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(29383);
 script_version ("$Revision: 1.5 $");
 script_name(english: "SuSE Security Update:  Security update for avahi (avahi-3845)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch avahi-3845");
 script_set_attribute(attribute: "description", value: "Local attackers could send empty TXT data via D-BUS,
causing the avahi daemon to exit. CVE-2007-3372 has been
assigned to this issue.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:L/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch avahi-3845");
script_end_attributes();

script_cve_id("CVE-2007-3372");
script_summary(english: "Check for the avahi-3845 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");

if ( rpm_check( reference:"avahi-0.6.5-29.16", release:"SLED10") )
{
	security_note(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"avahi-glib-0.6.5-29.16", release:"SLED10") )
{
	security_note(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
