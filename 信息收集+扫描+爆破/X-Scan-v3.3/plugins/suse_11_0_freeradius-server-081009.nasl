
#
# (C) Tenable Network Security, Inc.
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(39963);
 script_version("$Revision: 1.3 $");
 script_name(english: "SuSE 11.0 Security Update:  freeradius-server (2008-10-09)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing a security patch for freeradius-server");
 script_set_attribute(attribute: "description", value: "This update fixes a possible symlink attack in the script
freeradius-dialupadmin. (CVE-2008-4474)
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Run yast to install the security patch for freeradius-server");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=433762");
script_end_attributes();

 script_cve_id("CVE-2008-4474");
script_summary(english: "Check for the freeradius-server package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"freeradius-server-2.0.5-8.3", release:"SUSE11.0", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"freeradius-server-2.0.5-8.3", release:"SUSE11.0", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"freeradius-server-devel-2.0.5-8.3", release:"SUSE11.0", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"freeradius-server-devel-2.0.5-8.3", release:"SUSE11.0", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"freeradius-server-dialupadmin-2.0.5-8.3", release:"SUSE11.0", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"freeradius-server-dialupadmin-2.0.5-8.3", release:"SUSE11.0", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"freeradius-server-doc-2.0.5-8.3", release:"SUSE11.0", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"freeradius-server-doc-2.0.5-8.3", release:"SUSE11.0", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"freeradius-server-libs-2.0.5-8.3", release:"SUSE11.0", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"freeradius-server-libs-2.0.5-8.3", release:"SUSE11.0", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"freeradius-server-utils-2.0.5-8.3", release:"SUSE11.0", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"freeradius-server-utils-2.0.5-8.3", release:"SUSE11.0", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
exit(0,"Host is not affected");
