
#
# (C) Tenable Network Security, Inc.
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(40286);
 script_version("$Revision: 1.3 $");
 script_name(english: "SuSE 11.1 Security Update:  openslp (2009-02-03)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing a security patch for openslp");
 script_set_attribute(attribute: "description", value: "OpenSLP prior this update does not correctly check the
return values of OpenSSL functions.
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "solution", value: "Run yast to install the security patch for openslp");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=465270");
script_end_attributes();

script_summary(english: "Check for the openslp package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"openslp-1.2.0-168.10.1", release:"SUSE11.1", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"openslp-1.2.0-168.10.1", release:"SUSE11.1", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"openslp-32bit-1.2.0-168.10.1", release:"SUSE11.1", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"openslp-devel-1.2.0-168.10.1", release:"SUSE11.1", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"openslp-devel-1.2.0-168.10.1", release:"SUSE11.1", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"openslp-server-1.2.0-168.10.1", release:"SUSE11.1", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"openslp-server-1.2.0-168.10.1", release:"SUSE11.1", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
exit(0,"Host is not affected");
