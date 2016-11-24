
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(12412);
 script_version ("$Revision: 1.8 $");
 script_name(english: "RHSA-2003-244: apache");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2003-244");
 script_set_attribute(attribute: "description", value: '
  Updated Apache and mod_ssl packages that fix several minor security issues
  are now available for Red Hat Enterprise Linux.

  The Apache HTTP server is a powerful, full-featured, efficient, and
  freely-available Web server.

  Ben Laurie found a bug in the optional renegotiation code in mod_ssl
  which can cause cipher suite restrictions to be ignored. This is triggered
  if optional renegotiation is used (SSLOptions +OptRenegotiate) along with
  verification of client certificates and a change to the cipher suite over
  the renegotiation. The Common Vulnerabilities and Exposures project
  (cve.mitre.org) has assigned the name CAN-2003-0192 to this issue.

  Apache does not filter terminal escape sequences from its error logs, which
  could make it easier for attackers to insert those sequences into terminal
  emulators containing vulnerabilities related to escape sequences. The
  Common Vulnerabilities and Exposures project (cve.mitre.org) has assigned
  the name CAN-2003-0020 to this issue.

  It is possible to get Apache 1.3 to get into an infinite loop handling
  internal redirects and nested subrequests. A patch for this issue adds a
  new LimitInternalRecursion directive.

  All users of the Apache HTTP Web Server are advised to upgrade to the
  applicable errata packages, which contain back-ported fixes correcting
  these issues.

  After the errata packages are installed, restart the Web service by running
  the following command:

  /sbin/service httpd restart


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2003-244.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2003-0020", "CVE-2003-0192");
script_summary(english: "Check for the version of the apache packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"apache-1.3.27-3", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"apache-devel-1.3.27-3", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"apache-manual-1.3.27-3", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mod_ssl-2.8.12-3", release:'RHEL2.1') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
