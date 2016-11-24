
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(29301);
 script_version ("$Revision: 1.4 $");
 script_name(english: "RHSA-2007-1076: python");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2007-1076");
 script_set_attribute(attribute: "description", value: '
  Updated python packages that fix several security issues are now available
  for Red Hat Enterprise Linux 3 and 4.

  This update has been rated as having moderate security impact by the Red
  Hat Security Response Team.

  Python is an interpreted, interactive, object-oriented programming
  language.

  An integer overflow flaw was discovered in the way Python\'s pcre module
  handled certain regular expressions. If a Python application used the pcre
  module to compile and execute untrusted regular expressions, it may be
  possible to cause the application to crash, or allow arbitrary code
  execution with the privileges of the Python interpreter. (CVE-2006-7228)

  A flaw was discovered in the strxfrm() function of Python\'s locale module.
  Strings generated by this function were not properly NULL-terminated. This
  may possibly cause disclosure of data stored in the memory of a Python
  application using this function. (CVE-2007-2052)

  Multiple integer overflow flaws were discovered in Python\'s imageop module.
  If an application written in Python used the imageop module to process
  untrusted images, it could cause the application to crash, enter an
  infinite loop, or possibly execute arbitrary code with the privileges of
  the Python interpreter. (CVE-2007-4965)

  Users of Python are advised to upgrade to these updated packages, which
  contain backported patches to resolve these issues.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2007-1076.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2006-7228", "CVE-2007-2052", "CVE-2007-4965");
script_summary(english: "Check for the version of the python packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"python-2.2.3-6.8", release:'RHEL3') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"python-devel-2.2.3-6.8", release:'RHEL3') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"python-tools-2.2.3-6.8", release:'RHEL3') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"tkinter-2.2.3-6.8", release:'RHEL3') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"python-2.3.4-14.4.el4_6.1", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"python-devel-2.3.4-14.4.el4_6.1", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"python-docs-2.3.4-14.4.el4_6.1", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"python-tools-2.3.4-14.4.el4_6.1", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"tkinter-2.3.4-14.4.el4_6.1", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
