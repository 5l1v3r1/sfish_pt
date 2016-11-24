
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(34954);
 script_version ("$Revision: 1.4 $");
 script_name(english: "RHSA-2008-0617: vim");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2008-0617");
 script_set_attribute(attribute: "description", value: '
  Updated vim packages that fix various security issues are now available for
  Red Hat Enterprise Linux 3 and 4.

  This update has been rated as having moderate security impact by the Red
  Hat Security Response Team.

  Vim (Visual editor IMproved) is an updated and improved version of the vi
  editor.

  Several input sanitization flaws were found in Vim\'s keyword and tag
  handling. If Vim looked up a document\'s maliciously crafted tag or keyword,
  it was possible to execute arbitrary code as the user running Vim.
  (CVE-2008-4101)

  A heap-based overflow flaw was discovered in Vim\'s expansion of file name
  patterns with shell wildcards. An attacker could create a specially-crafted
  file or directory name that, when opened by Vim, caused the application to
  crash or, possibly, execute arbitrary code. (CVE-2008-3432)

  Several input sanitization flaws were found in various Vim system
  functions. If a user opened a specially crafted file, it was possible to
  execute arbitrary code as the user running Vim. (CVE-2008-2712)

  Ulf H  rnhammar, of Secunia Research, discovered a format string flaw in
  Vim\'s help tag processor. If a user was tricked into executing the
  "helptags" command on malicious data, arbitrary code could be executed with
  the permissions of the user running Vim. (CVE-2007-2953)

  All Vim users are advised to upgrade to these updated packages, which
  contain backported patches to correct these issues.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2008-0617.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2007-2953", "CVE-2008-2712", "CVE-2008-3432", "CVE-2008-4101");
script_summary(english: "Check for the version of the vim packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"vim-X11-6.3.046-0.30E.11", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"vim-common-6.3.046-0.30E.11", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"vim-enhanced-6.3.046-0.30E.11", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"vim-minimal-6.3.046-0.30E.11", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"vim-X11-6.3.046-1.el4_7.5z", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"vim-common-6.3.046-1.el4_7.5z", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"vim-enhanced-6.3.046-1.el4_7.5z", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"vim-minimal-6.3.046-1.el4_7.5z", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
