
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(29503);
 script_version ("$Revision: 1.6 $");
 script_name(english: "SuSE Security Update:  Security update for libksba (libksba-1867)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch libksba-1867");
 script_set_attribute(attribute: "description", value: "The gpgsm program (which uses the libksba library) crashed
when verifying a signature with certain malformed x.509
certificates.
");
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "solution", value: "Install the security patch libksba-1867");
script_end_attributes();

script_summary(english: "Check for the libksba-1867 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");

if ( rpm_check( reference:"libksba-0.9.12-14.5", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libksba-devel-0.9.12-14.5", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libksba-0.9.12-14.5", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libksba-devel-0.9.12-14.5", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
