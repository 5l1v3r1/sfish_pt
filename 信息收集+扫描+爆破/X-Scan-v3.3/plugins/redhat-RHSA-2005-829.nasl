
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(20146);
 script_version ("$Revision: 1.5 $");
 script_name(english: "RHSA-2005-829: openssl");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2005-829");
 script_set_attribute(attribute: "description", value: '
  Updated OpenSSL packages that fix a remote denial of service vulnerability
  are now available for Red Hat Enterprise Linux 2.1

  This update has been rated as having important security impact by the Red
  Hat Security Response Team.

  The OpenSSL toolkit implements Secure Sockets Layer (SSL v2/v3),
  Transport Layer Security (TLS v1) protocols, and serves as a full-strength
  general purpose cryptography library.

  Testing performed by the OpenSSL group using the Codenomicon TLS Test Tool
  uncovered a null-pointer assignment in the do_change_cipher_spec()
  function. A remote attacker could perform a carefully crafted SSL/TLS
  handshake against a server that uses the OpenSSL library in such a way as
  to cause OpenSSL to crash. Depending on the server this could lead to a
  denial of service. (CVE-2004-0079)

  This issue was reported as not affecting OpenSSL versions prior to 0.9.6c,
  and testing with the Codenomicon Test Tool showed that OpenSSL 0.9.6b as
  shipped in Red Hat Enterprise Linux 2.1 did not crash. However, an
  alternative reproducer has been written which shows that this issue does
  affect versions of OpenSSL prior to 0.9.6c.

  Users of OpenSSL are advised to upgrade to these updated packages, which
  contain a patch provided by the OpenSSL group that protects against this
  issue.

  NOTE: Because server applications are affected by this issue, users are
  advised to either restart all services that use OpenSSL functionality or
  restart their systems after installing these updates.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2005-829.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2004-0079");
script_summary(english: "Check for the version of the openssl packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"openssl-0.9.6b-42", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"openssl-devel-0.9.6b-42", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"openssl-perl-0.9.6b-42", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"openssl095a-0.9.5a-28", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"openssl096-0.9.6-28", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
