
#
# (C) Tenable Network Security, Inc.
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(40140);
 script_version("$Revision: 1.3 $");
 script_name(english: "SuSE 11.0 Security Update:  sudo (2009-01-26)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing a security patch for sudo");
 script_set_attribute(attribute: "description", value: "This update of sudo fixes a bug that allowed - depending on
the sudoers rules - a sudo-user to execute arbitrary shell
commands as root.
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "solution", value: "Run yast to install the security patch for sudo");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=468923");
script_end_attributes();

script_summary(english: "Check for the sudo package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"sudo-1.6.9p15-13.4", release:"SUSE11.0", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"sudo-1.6.9p15-13.4", release:"SUSE11.0", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
exit(0,"Host is not affected");
