
#
# (C) Tenable Network Security, Inc.
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(40546);
 script_version("$Revision: 1.3 $");
 script_name(english: "SuSE 11.1 Security Update:  memcached (2009-08-06)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing a security patch for memcached");
 script_set_attribute(attribute: "description", value: "This update of memcached fixes a signedness problem which
may lead to a buffer too small to hold all data received
from the network, this may allow arbitrary remote code
execution. (CVE-2009-2415) Additionally an information leak
was fixed (CVE-2009-1494, CVE-2009-1255 )
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Run yast to install the security patch for memcached");
script_set_attribute(attribute: "see_also", value: "https://bugzilla.novell.com/show_bug.cgi?id=527875");
script_end_attributes();

 script_cve_id("CVE-2009-1255", "CVE-2009-1494", "CVE-2009-2415");
script_summary(english: "Check for the memcached package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"memcached-1.2.6-5.7.1", release:"SUSE11.1", cpu:"i586") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
if ( rpm_check( reference:"memcached-1.2.6-5.7.1", release:"SUSE11.1", cpu:"x86_64") )
{
	security_hole(port:0, extra:rpm_report_get() );
	exit(0);
}
exit(0,"Host is not affected");
