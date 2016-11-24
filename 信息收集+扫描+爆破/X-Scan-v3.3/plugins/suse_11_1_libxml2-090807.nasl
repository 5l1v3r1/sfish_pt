
#
# (C) Tenable Network Security, Inc.
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(40575);
 script_version("$Revision: 1.2 $");
 script_name(english: "SuSE 11.1 Security Update:  libxml2 (2009-08-07)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing a security patch for libxml2");
 script_set_attribute(attribute: "description", value: "This update of libxml2 does not use pointers after they
were freed anymore. (CVE-2009-2416) Additionally a
stack-based buffer overflow was fixed while parsing the
root XML document. (CVE-2009-2414)
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "solution", value: "Run yast to install the security patch for libxml2");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=528007");
script_end_attributes();

 script_cve_id("CVE-2009-2414", "CVE-2009-2416");
script_summary(english: "Check for the libxml2 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"libxml2-2.7.1-9.8.1", release:"SUSE11.1", cpu:"i586") )
{
	security_warning(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"libxml2-2.7.1-9.8.1", release:"SUSE11.1", cpu:"x86_64") )
{
	security_warning(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"libxml2-32bit-2.7.1-9.8.1", release:"SUSE11.1", cpu:"x86_64") )
{
	security_warning(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"libxml2-devel-2.7.1-9.8.1", release:"SUSE11.1", cpu:"i586") )
{
	security_warning(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"libxml2-devel-2.7.1-9.8.1", release:"SUSE11.1", cpu:"x86_64") )
{
	security_warning(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"libxml2-devel-32bit-2.7.1-9.8.1", release:"SUSE11.1", cpu:"x86_64") )
{
	security_warning(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"libxml2-doc-2.7.1-9.8.1", release:"SUSE11.1", cpu:"i586") )
{
	security_warning(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"libxml2-doc-2.7.1-9.8.1", release:"SUSE11.1", cpu:"x86_64") )
{
	security_warning(port:0, extra:rpm_report_get() );
	exit(0);
}
exit(0,"Host is not affected");
