
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(32184);
 script_version ("$Revision: 1.3 $");
 script_name(english: "SuSE Security Update:  texlive security update (texlive-bin-5221)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch texlive-bin-5221");
 script_set_attribute(attribute: "description", value: "Buffer overflows in dvips and dviljk could be triggered by
specially crafted dvi files (CVE-2007-5935, CVE-2007-5937).
dvips additionally created temporary files in an insecure
manner (CVE-2007-5936).
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch texlive-bin-5221");
script_end_attributes();

script_cve_id("CVE-2007-5935", "CVE-2007-5937", "CVE-2007-5936");
script_summary(english: "Check for the texlive-bin-5221 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"texlive-bin-2007-68.3", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"texlive-bin-cjk-2007-68.3", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"texlive-bin-devel-2007-68.3", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"texlive-bin-dvilj-2007-68.3", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"texlive-bin-latex-2007-68.3", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"texlive-bin-metapost-2007-68.3", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"texlive-bin-omega-2007-68.3", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"texlive-bin-xetex-2007-68.3", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
