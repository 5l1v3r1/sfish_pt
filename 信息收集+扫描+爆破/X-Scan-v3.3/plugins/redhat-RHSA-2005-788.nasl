
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(19836);
 script_version ("$Revision: 1.6 $");
 script_name(english: "RHSA-2005-788: HelixPlayer");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2005-788");
 script_set_attribute(attribute: "description", value: '
  An updated HelixPlayer package that fixes a string format issue is now
  available.

  This update has been rated as having critical security impact by the Red
  Hat Security Response Team.

  HelixPlayer is a media player.

  A format string bug was discovered in the way HelixPlayer processes RealPix
  (.rp) files. It is possible for a malformed RealPix file to execute
  arbitrary code as the user running HelixPlayer. The Common Vulnerabilities
  and Exposures project (cve.mitre.org) has assigned the name CAN-2005-2710
  to this issue.

  All users of HelixPlayer are advised to upgrade to this updated package,
  which contains HelixPlayer version 10.0.6 and is not vulnerable to this
  issue.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2005-788.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2005-2629", "CVE-2005-2710", "CVE-2005-2922");
script_summary(english: "Check for the version of the HelixPlayer packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"HelixPlayer-1.0.6-0.EL4.1", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
