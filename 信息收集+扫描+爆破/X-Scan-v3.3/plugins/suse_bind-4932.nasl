
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(31450);
 script_version ("$Revision: 1.8 $");
 script_name(english: "SuSE Security Update:  Security update for bind (bind-4932)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch bind-4932");
 script_set_attribute(attribute: "description", value: "Certain input data could trigger a buffer overflow in the
'inet_network' function of libbind. Applications that use
this function could therefore potentially be crashed or
exploited to execute arbitrary code. Bind itself is not
affected though (CVE-2008-0122).
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Install the security patch bind-4932");
script_end_attributes();

script_cve_id("CVE-2008-0122");
script_summary(english: "Check for the bind-4932 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");

if ( rpm_check( reference:"bind-9.3.4-1.19", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"bind-chrootenv-9.3.4-1.19", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"bind-devel-9.3.4-1.19", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"bind-doc-9.3.4-1.19", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"bind-libs-9.3.4-1.19", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"bind-utils-9.3.4-1.19", release:"SLES10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"bind-libs-9.3.4-1.19", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"bind-utils-9.3.4-1.19", release:"SLED10") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
