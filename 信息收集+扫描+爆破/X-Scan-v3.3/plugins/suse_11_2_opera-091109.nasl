
#
# (C) Tenable Network Security, Inc.
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(42464);
 script_version("$Revision: 1.1 $");
 script_name(english: "SuSE 11.2 Security Update:  opera (2009-11-09)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing a security patch for opera");
 script_set_attribute(attribute: "description", value: "Version upgrade of Opera to 10.1 to fix:
- CVE-2009-3265: CVSS v2 Base Score: 4.3 CVE-2009-3266:
  CVSS v2 Base Score: 4.3 two XSS attacks via RSS/Atom
- CVE-2009-3831: CVSS v2 Base Score: 9.3 possible remote
  arbitrary code execution via crafted domain names
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Run yast to install the security patch for opera");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=541665");
script_end_attributes();

 script_cve_id("CVE-2009-3265", "CVE-2009-3266", "CVE-2009-3831");
script_summary(english: "Check for the opera package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"opera-10.01-1.1.1", release:"SUSE11.2", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"opera-10.01-1.1.1", release:"SUSE11.2", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
exit(0,"Host is not affected");
