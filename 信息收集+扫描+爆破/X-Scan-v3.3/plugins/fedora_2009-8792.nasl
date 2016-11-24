
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2009-8792
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(40676);
 script_version ("$Revision: 1.2 $");
script_name(english: "Fedora 10 2009-8792: afuse");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2009-8792 (afuse)");
 script_set_attribute(attribute: "description", value: "Afuse is an automounting file system implemented in user-space using FUSE.
Afuse currently implements the most basic functionality that can be expected
by an automounter; that is it manages a directory of virtual directories. If
one of these virtual directories is accessed and is not already automounted,
afuse will attempt to mount a filesystem onto that directory. If the mount
succeeds the requested access proceeds as normal, otherwise it will fail
with an error.

-
Update Information:

Fixes CVE-2008-2232:
[9]http://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2008-2232
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2008-2232");
script_summary(english: "Check for the version of the afuse package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"afuse-0.2-4.fc10", release:"FC10") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
