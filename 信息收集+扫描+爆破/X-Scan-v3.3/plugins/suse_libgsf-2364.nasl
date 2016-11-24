
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(27324);
 script_version ("$Revision: 1.5 $");
 script_name(english: "SuSE Security Update:  libgsf security update (libgsf-2364)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch libgsf-2364");
 script_set_attribute(attribute: "description", value: "Specially crafted OLE documents enabled attackers to use a
heap buffer overlow for executing code (CVE-2006-4514).
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch libgsf-2364");
script_end_attributes();

script_cve_id("CVE-2006-4514");
script_summary(english: "Check for the libgsf-2364 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"libgsf-1.13.99-13.7", release:"SUSE10.1") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libgsf-32bit-1.13.99-13.7", release:"SUSE10.1") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libgsf-64bit-1.13.99-13.7", release:"SUSE10.1") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
