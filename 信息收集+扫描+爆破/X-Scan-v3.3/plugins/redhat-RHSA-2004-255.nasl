
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(12508);
 script_version ("$Revision: 1.9 $");
 script_name(english: "RHSA-2004-255:   kernel");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2004-255");
 script_set_attribute(attribute: "description", value: '
  Updated kernel packages for Red Hat Enterprise Linux 3 that fix security
  vulnerabilities are now available.

  The Linux kernel handles the basic functions of the operating system.

  A flaw was found in Linux kernel versions 2.4 and 2.6 for x86 and x86_64
  that allowed local users to cause a denial of service (system crash) by
  triggering a signal handler with a certain sequence of fsave and frstor
  instructions. The Common Vulnerabilities and Exposures project
  (cve.mitre.org) has assigned the name CAN-2004-0554 to this issue.

  Another flaw was discovered in an error path supporting the clone()
  system call that allowed local users to cause a denial of service
  (memory leak) by passing invalid arguments to clone() running in an
  infinite loop of a user\'s program. The Common Vulnerabilities and
  Exposures project (cve.mitre.org) has assigned the name CAN-2004-0427
  to this issue.

  Enhancements were committed to the 2.6 kernel by Al Viro which enabled the
  Sparse source code checking tool to check for a certain class of kernel
  bugs. A subset of these fixes also applies to various drivers in the 2.4
  kernel. Although the majority of these resides in drivers unsupported in
  Red Hat Enterprise Linux 3, the flaws could lead to privilege escalation or
  access to kernel memory. The Common Vulnerabilities and Exposures project
  (cve.mitre.org) has assigned the name CAN-2004-0495 to these issues.

  All Red Hat Enterprise Linux 3 users are advised to upgrade their kernels
  to the packages associated with their machine architectures and
  configurations as listed in this erratum. These packages contain
  backported patches to correct these issues.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2004-255.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2004-0427", "CVE-2004-0495", "CVE-2004-0554");
script_summary(english: "Check for the version of the   kernel packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"  kernel-2.4.21-15.0.2.EL.athlon.rpm                        05b0bcb454ac5454479481d0288fbf20", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"kernel-2.4.21-15.0.2.EL", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"kernel-BOOT-2.4.21-15.0.2.EL", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"kernel-doc-2.4.21-15.0.2.EL", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"kernel-hugemem-2.4.21-15.0.2.EL", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"kernel-hugemem-unsupported-2.4.21-15.0.2.EL", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"  kernel-smp-2.4.21-15.0.2.EL.athlon.rpm                    96eb477ac938da01b729b5ac5ed36e3b", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"kernel-smp-2.4.21-15.0.2.EL", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"  kernel-smp-unsupported-2.4.21-15.0.2.EL.athlon.rpm        9d24273cc70bb6be810984cb3f3d0a36", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"kernel-smp-unsupported-2.4.21-15.0.2.EL", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"kernel-source-2.4.21-15.0.2.EL", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"  kernel-unsupported-2.4.21-15.0.2.EL.athlon.rpm            17f10f04cffc9751afb1499aaff00fdc", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"kernel-unsupported-2.4.21-15.0.2.EL", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
