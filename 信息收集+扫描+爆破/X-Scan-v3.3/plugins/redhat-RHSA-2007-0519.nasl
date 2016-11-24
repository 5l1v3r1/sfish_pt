
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(25722);
 script_version ("$Revision: 1.5 $");
 script_name(english: "RHSA-2007-0519: xorg");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2007-0519");
 script_set_attribute(attribute: "description", value: '
  Updated X.org packages that correct a flaw in the way the X.Org X11 xfs
  font server starts are now available for Red Hat Enterprise Linux 4.

  This update has been rated as having moderate security impact by the Red
  Hat Security Response Team.

  X.org is an open source implementation of the X Window System. It provides
  the basic low-level functionality that full-fledged graphical user
  interfaces are designed upon.

  A temporary file flaw was found in the way the X.Org X11 xfs font server
  startup script executes. A local user could modify the permissions of the
  file of their choosing, possibly elevating their local privileges
  (CVE-2007-3103).

  Users of X.org should upgrade to these updated packages, which contain a
  backported patch and are not vulnerable to these issues.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:L/AC:H/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2007-0519.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2007-3103");
script_summary(english: "Check for the version of the xorg packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"xorg-x11-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-Mesa-libGL-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-Mesa-libGLU-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-Xdmx-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-Xnest-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-Xvfb-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-deprecated-libs-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-deprecated-libs-devel-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-devel-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-doc-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-font-utils-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-libs-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-sdk-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-tools-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-twm-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-xauth-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-xdm-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"xorg-x11-xfs-6.8.2-1.EL.19", release:'RHEL4') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
