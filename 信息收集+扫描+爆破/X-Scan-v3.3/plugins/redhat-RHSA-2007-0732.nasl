
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(25818);
 script_version ("$Revision: 1.5 $");
 script_name(english: "RHSA-2007-0732: poppler");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2007-0732");
 script_set_attribute(attribute: "description", value: '
  Updated poppler packages that fix a security issue in PDF handling are
  now available for Red Hat Enterprise Linux 5.

  This update has been rated as having important security impact by the Red
  Hat Security Response Team.

  Poppler is a PDF rendering library, used by applications such as evince.

  Maurycy Prodeus discovered an integer overflow flaw in the processing
  of PDF files. An attacker could create a malicious PDF file that would
  cause an application linked with poppler to crash or potentially execute
  arbitrary code when opened. (CVE-2007-3387)

  All users of poppler should upgrade to these updated packages, which
  contain a backported patch to resolve this issue.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2007-0732.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2007-3387");
script_summary(english: "Check for the version of the poppler packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"poppler-0.5.4-4.1.el5", release:'RHEL5') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"poppler-devel-0.5.4-4.1.el5", release:'RHEL5') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"poppler-utils-0.5.4-4.1.el5", release:'RHEL5') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
