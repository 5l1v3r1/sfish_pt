
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(40725);
 script_version ("$Revision: 1.2 $");
 script_name(english: "RHSA-2008-0790: java");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2008-0790");
 script_set_attribute(attribute: "description", value: '
  Updated java-1.5.0-ibm packages that fix several security issues are now
  available for Red Hat Enterprise Linux 4 Extras and 5 Supplementary.

  This update has been rated as having critical security impact by the Red
  Hat Security Response Team.

  The IBM 1.5.0 Java release includes the IBM Java 2 Runtime Environment and
  the IBM Java 2 Software Development Kit.

  Multiple vulnerabilities with unsigned applets were reported. A remote
  attacker could misuse an unsigned applet to connect to localhost services
  running on the host running the applet. (CVE-2008-3104)

  A vulnerability in the XML processing API was found. A remote attacker who
  caused malicious XML to be processed by an untrusted applet or application
  was able to elevate permissions to access URLs on a remote host.
  (CVE-2008-3106)

  A buffer overflow vulnerability was found in the font processing code. This
  allowed remote attackers to extend the permissions of an untrusted applet
  or application, allowing it to read and/or write local files, as well as to
  execute local applications accessible to the user running the untrusted
  application. (CVE-2008-3108)

  Several buffer overflow vulnerabilities in Java Web Start were reported.
  These vulnerabilities allowed an untrusted Java Web Start application to
  elevate its privileges, allowing it to read and/or write local files, as
  well as to execute local applications accessible to the user running the
  untrusted application. (CVE-2008-3111)

  Two file processing vulnerabilities in Java Web Start were found. A remote
  attacker, by means of an untrusted Java Web Start application, was able to
  create or delete arbitrary files with the permissions of the user running
  the untrusted application. (CVE-2008-3112, CVE-2008-3113)

  A vulnerability in Java Web Start when processing untrusted applications
  was reported. An attacker was able to acquire sensitive information, such
  as the cache location. (CVE-2008-3114)

  All users of java-1.5.0-ibm are advised to upgrade to these updated
  packages, that contain the IBM 1.5.0 SR8 Java release, which resolves
  these issues.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2008-0790.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2008-3104", "CVE-2008-3106", "CVE-2008-3108", "CVE-2008-3111", "CVE-2008-3112", "CVE-2008-3113", "CVE-2008-3114");
script_summary(english: "Check for the version of the java packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"java-1.5.0-ibm-1.5.0.8-1jpp.1.el4", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"java-1.5.0-ibm-demo-1.5.0.8-1jpp.1.el4", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"java-1.5.0-ibm-devel-1.5.0.8-1jpp.1.el4", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"java-1.5.0-ibm-javacomm-1.5.0.8-1jpp.1.el4", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"java-1.5.0-ibm-jdbc-1.5.0.8-1jpp.1.el4", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"java-1.5.0-ibm-plugin-1.5.0.8-1jpp.1.el4", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"java-1.5.0-ibm-src-1.5.0.8-1jpp.1.el4", release:'RHEL4') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"java-1.5.0-ibm-1.5.0.8-1jpp.1.el4", release:'RHEL4.6.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"java-1.5.0-ibm-demo-1.5.0.8-1jpp.1.el4", release:'RHEL4.6.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"java-1.5.0-ibm-devel-1.5.0.8-1jpp.1.el4", release:'RHEL4.6.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"java-1.5.0-ibm-javacomm-1.5.0.8-1jpp.1.el4", release:'RHEL4.6.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"java-1.5.0-ibm-jdbc-1.5.0.8-1jpp.1.el4", release:'RHEL4.6.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"java-1.5.0-ibm-plugin-1.5.0.8-1jpp.1.el4", release:'RHEL4.6.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"java-1.5.0-ibm-src-1.5.0.8-1jpp.1.el4", release:'RHEL4.6.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
