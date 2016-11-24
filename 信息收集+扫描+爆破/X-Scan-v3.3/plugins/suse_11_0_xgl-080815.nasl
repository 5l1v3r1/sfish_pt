
#
# (C) Tenable Network Security, Inc.
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(40155);
 script_version("$Revision: 1.3 $");
 script_name(english: "SuSE 11.0 Security Update:  xgl (2008-08-15)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing a security patch for xgl");
 script_set_attribute(attribute: "description", value: "This update fixes multiple vulnerabilities reported by
iDefense for the included X server:
- CVE-2008-2360 - RENDER Extension heap buffer overflow
- CVE-2008-2361 - RENDER Extension crash
- CVE-2008-2362 - RENDER Extension memory corruption 
- CVE-2008-1379 - MIT-SHM arbitrary memory read
- CVE-2008-1377 - RECORD and Security extensions  memory
  corruption
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Run yast to install the security patch for xgl");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=387544");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=332447");
script_end_attributes();

 script_cve_id("CVE-2008-1377", "CVE-2008-1379", "CVE-2008-2360", "CVE-2008-2361", "CVE-2008-2362");
script_summary(english: "Check for the xgl package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"xgl-git_071026-79.3", release:"SUSE11.0", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"xgl-git_071026-79.3", release:"SUSE11.0", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
exit(0,"Host is not affected");
