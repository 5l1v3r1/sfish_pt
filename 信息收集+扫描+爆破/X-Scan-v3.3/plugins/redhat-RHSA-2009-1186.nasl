
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(40441);
 script_version ("$Revision: 1.4 $");
 script_name(english: "RHSA-2009-1186: nspr");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2009-1186");
 script_set_attribute(attribute: "description", value: '
  Updated nspr and nss packages that fix security issues, bugs, and add an
  enhancement are now available for Red Hat Enterprise Linux 5.

  This update has been rated as having critical security impact by the Red
  Hat Security Response Team.

  The packages with this update are identical to the packages released by
  RHBA-2009:1161 on the 20th of July 2009. They are being reissued as a Red
  Hat Security Advisory as they fixed a number of security issues that were
  made public today. If you are installing these packages for the first time,
  they also provide a number of bug fixes and add an enhancement, as detailed
  in RHBA-2009:1161. Since the packages are identical, there is no need to
  install this update if RHBA-2009:1161 has already been installed.

  Netscape Portable Runtime (NSPR) provides platform independence for non-GUI
  operating system facilities. These facilities include threads, thread
  synchronization, normal file and network I/O, interval timing, calendar
  time, basic memory management (malloc and free), and shared library linking.

  Network Security Services (NSS) is a set of libraries designed to support
  the cross-platform development of security-enabled client and server
  applications. Applications built with NSS can support SSLv2, SSLv3, TLS,
  and other security standards.

  These updated packages upgrade NSS from the previous version, 3.12.2, to a
  prerelease of version 3.12.4. The version of NSPR has also been upgraded
  from 4.7.3 to 4.7.4.

  Moxie Marlinspike reported a heap overflow flaw in a regular expression
  parser in the NSS library used by browsers such as Mozilla Firefox to match
  common names in certificates. A malicious website could present a
  carefully-crafted certificate in such a way as to trigger the heap
  overflow, leading to a crash or, possibly, arbitrary code execution with
  the permissions of the user running the browser. (CVE-2009-2404)

  Note: in order to exploit this issue without further user interaction in
  Firefox, the carefully-crafted certificate would need to be signed by a
  Certificate Authority trusted by Firefox, otherwise Firefox presents the
  victim with a warning that the certificate is untrusted. Only if the user
  then accepts the certificate will the overflow take place.

  Dan Kaminsky discovered flaws in the way browsers such as Firefox handle
  NULL characters in a certificate. If an attacker is able to get a
  carefully-crafted certificate signed by a Certificate Authority trusted by
  Firefox, the attacker could use the certificate during a man-in-the-middle
  attack and potentially confuse Firefox into accepting it by mistake.
  (CVE-2009-2408)

  Dan Kaminsky found that browsers still accept certificates with MD2 hash
  signatures, even though MD2 is no longer considered a cryptographically
  strong algorithm. This could make it easier for an attacker to create a
  malicious certificate that would be treated as trusted by a browser. NSS
  now disables the use of MD2 and MD4 algorithms inside signatures by
  default. (CVE-2009-2409)

  All users of nspr and nss are advised to upgrade to these updated packages,
  which resolve these issues and add an enhancement.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2009-1186.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2009-2404", "CVE-2009-2408", "CVE-2009-2409");
script_summary(english: "Check for the version of the nspr packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"nspr-4.7.4-1.el5_3.1", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"nspr-devel-4.7.4-1.el5_3.1", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"nss-3.12.3.99.3-1.el5_3.2", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"nss-devel-3.12.3.99.3-1.el5_3.2", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"nss-pkcs11-devel-3.12.3.99.3-1.el5_3.2", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"nss-tools-3.12.3.99.3-1.el5_3.2", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"nspr-4.7.4-1.el5_3.1", release:'RHEL5.3.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"nspr-devel-4.7.4-1.el5_3.1", release:'RHEL5.3.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"nss-3.12.3.99.3-1.el5_3.2", release:'RHEL5.3.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"nss-devel-3.12.3.99.3-1.el5_3.2", release:'RHEL5.3.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"nss-pkcs11-devel-3.12.3.99.3-1.el5_3.2", release:'RHEL5.3.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"nss-tools-3.12.3.99.3-1.el5_3.2", release:'RHEL5.3.') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
