
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2009-8594
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(40604);
 script_version ("$Revision: 1.2 $");
script_name(english: "Fedora 10 2009-8594: libxml");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2009-8594 (libxml)");
 script_set_attribute(attribute: "description", value: "This library allows old Gnome-1 applications to manipulate XML files.

-
Update Information:

This update includes patches from RHEL-3 addressing a number of security
vulnerabilities:    - CVE-2004-0110 (arbitrary code execution via a long URL)
-
CVE-2004-0989 (arbitrary code execution via a long URL)  - CVE-2009-2414 (stack
consumption DoS vulnerabilities)  - CVE-2009-2416 (use-after-free DoS
vulnerabilities)
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2004-0110", "CVE-2004-0989", "CVE-2009-2414", "CVE-2009-2416");
script_summary(english: "Check for the version of the libxml package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"libxml-1.8.17-24.fc10", release:"FC10") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
