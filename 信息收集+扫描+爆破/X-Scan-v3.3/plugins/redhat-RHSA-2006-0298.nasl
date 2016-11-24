
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(22084);
 script_version ("$Revision: 1.5 $");
 script_name(english: "RHSA-2006-0298: openssh");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2006-0298");
 script_set_attribute(attribute: "description", value: '
  Updated openssh packages that fix bugs in sshd are now available for Red
  Hat Enterprise Linux 3.

  This update has been rated as having low security impact by the Red Hat
  Security Response Team.

  OpenSSH is OpenBSD\'s SSH (Secure SHell) protocol implementation. This
  package includes the core files necessary for both the OpenSSH client and
  server.

  An arbitrary command execution flaw was discovered in the way scp copies
  files locally. It is possible for a local attacker to create a file with a
  carefully crafted name that could execute arbitrary commands as the user
  running scp to copy files locally. (CVE-2006-0225)

  The SSH daemon, when restricting host access by numeric IP addresses and
  with VerifyReverseMapping disabled, allows remote attackers to bypass
  "from=" and "user@host" address restrictions by connecting to a host from a
  system whose reverse DNS hostname contains the numeric IP address.
  (CVE-2003-0386)

  The following issues have also been fixed in this update:

  * If the sshd service was stopped using the sshd init script while the
  main sshd daemon was not running, the init script would kill other sshd
  processes, such as the running sessions. For example, this could happen
  when the \'service sshd stop\' command was issued twice.

  * When privilege separation was enabled, the last login message was printed
  only for the root user.

  * The sshd daemon was sending messages to the system log from a signal
  handler when debug logging was enabled. This could cause a deadlock of
  the user\'s connection.

  All users of openssh should upgrade to these updated packages, which
  resolve these issues.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2006-0298.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2003-0386", "CVE-2006-0225");
script_summary(english: "Check for the version of the openssh packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"openssh-3.6.1p2-33.30.9", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"openssh-askpass-3.6.1p2-33.30.9", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"openssh-askpass-gnome-3.6.1p2-33.30.9", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"openssh-clients-3.6.1p2-33.30.9", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"openssh-server-3.6.1p2-33.30.9", release:'RHEL3') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
