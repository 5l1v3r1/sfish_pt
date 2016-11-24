
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2008-3250
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(32041);
 script_version ("$Revision: 1.3 $");
script_name(english: "Fedora 8 2008-3250: mt-daapd");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2008-3250 (mt-daapd)");
 script_set_attribute(attribute: "description", value: "The purpose of this project is built the best server software to serve
digital music to the Roku Soundbridge and iTunes; to be able to serve
the widest variety of digital music content over the widest range of
devices.

-
References:

[ 1 ] Bug #442688 - CVE-2008-1771 mt-daapd: integer overflow allowing remote
DoS and possibly arbitrary code execution
[9]https://bugzilla.redhat.com/show_bug.cgi?id=442688
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2008-1771");
script_summary(english: "Check for the version of the mt-daapd package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"mt-daapd-0.9-0.4.1696.fc8", release:"FC8") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
