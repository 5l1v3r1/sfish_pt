
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(17365);
 script_version ("$Revision: 1.6 $");
 script_name(english: "RHSA-2005-303: sylpheed");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2005-303");
 script_set_attribute(attribute: "description", value: '
  An updated sylpheed package that fixes a buffer overflow issue is now
  available.

  This update has been rated as having important security impact by the Red
  Hat Security Response Team.

  Sylpheed is a GTK+ based fast email client.

  A buffer overflow bug has been found in the way Sylpheed handles non-ASCII
  characters in the header of a message to which a victim replies. A
  carefully crafted email message could potentially allow an attacker to
  execute arbitrary code on a victim\'s machine if they reply to such a
  message. The Common Vulnerabilities and Exposures project (cve.mitre.org)
  has assigned the name CAN-2005-0667 to this issue.

  Users of Sylpheed should upgrade to this updated package, which contains a
  backported patch, and is not vulnerable to this issue.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2005-303.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2005-0667");
script_summary(english: "Check for the version of the sylpheed packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"sylpheed-0.5.0-3.EL21.1", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
