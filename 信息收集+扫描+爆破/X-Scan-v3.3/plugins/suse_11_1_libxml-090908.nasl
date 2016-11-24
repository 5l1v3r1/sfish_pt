
#
# (C) Tenable Network Security, Inc.
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(41004);
 script_version("$Revision: 1.1 $");
 script_name(english: "SuSE 11.1 Security Update:  libxml (2009-09-08)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing a security patch for libxml");
 script_set_attribute(attribute: "description", value: "This update of libxml does not use pointers after they were
freed anymore. (CVE-2009-2416)  Additionally a stack-based
buffer overflow was fixed while parsing the root XML
document. (CVE-2009-2414)
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "solution", value: "Run yast to install the security patch for libxml");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=530661");
script_end_attributes();

 script_cve_id("CVE-2009-2414", "CVE-2009-2416");
script_summary(english: "Check for the libxml package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"libxml-1.8.17-480.52.2", release:"SUSE11.1", cpu:"i586") )
{
	security_warning(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"libxml-1.8.17-480.52.2", release:"SUSE11.1", cpu:"x86_64") )
{
	security_warning(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"libxml-32bit-1.8.17-480.52.2", release:"SUSE11.1", cpu:"x86_64") )
{
	security_warning(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"libxml-devel-1.8.17-480.52.2", release:"SUSE11.1", cpu:"i586") )
{
	security_warning(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"libxml-devel-1.8.17-480.52.2", release:"SUSE11.1", cpu:"x86_64") )
{
	security_warning(port:0, extra:rpm_report_get() );
	exit(0);
}
exit(0,"Host is not affected");
