#
# (C) Tenable Network Security
#
#
# The text of this plugin is (C) Red Hat Inc.

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(12332);
 script_version ("$Revision: 1.7 $");
 script_cve_id("CVE-2002-0839", "CVE-2002-0843", "CVE-2002-0840", "CVE-2002-1157");

 script_name(english:"RHSA-2002-251: apache");
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing the patch for the advisory RHSA-2002-251");
 
 script_set_attribute(attribute:"description", value:
'
  Updated apache and httpd packages are available which fix a number of
  security issues for Red Hat Linux Advanced Server 2.1.

  [Updated 06 Feb 2003]
  Added fixed packages for Advanced Workstation 2.1

  The Apache HTTP server is a powerful, full-featured, efficient, and
  freely-available Web server.

  Buffer overflows in the ApacheBench support program (ab.c) in Apache
  versions prior to 1.3.27 allow a malicious Web server to cause a denial of
  service and possibly execute arbitrary code via a long response. The
  Common Vulnerabilities and Exposures project has assigned the name
  CVE-2002-0843 to this issue.

  Two cross-site scripting vulnerabilities are present in the error pages
  for the default "404 Not Found" error, and for the error response when a
  plain HTTP request is received on an SSL port. Both of these issues are
  only exploitable if the "UseCanonicalName" setting has been changed to
  "Off", and wildcard DNS is in use. These issues would allow remote
  attackers to execute scripts as other Web page visitors, for instance, to
  steal cookies. These issues affect versions of Apache 1.3 before 1.3.26,
  and versions of mod_ssl before 2.8.12. The Common Vulnerabilities and
  Exposures project has assigned the names CVE-2002-0840 and CVE-2002-1157 to
  these issues.

  The shared memory scoreboard in the HTTP daemon for Apache 1.3, prior to
  version 1.3.27, allowed a user running as the "apache" UID to send a
  SIGUSR1 signal to any process as root, resulting in a denial of service
  (process kill) or other such behavior that would not normally be allowed.
  The Common Vulnerabilities and Exposures project has assigned the name
  CVE-2002-0839 to this issue.

  All users of the Apache HTTP server are advised to upgrade to the
  applicable errata packages. For Red Hat Linux Advanced Server 2.1 these
  packages include Apache version 1.3.27 which is not vulnerable to
  these issues.

  Note that the instructions in the "Solution" section of this errata contain
  additional steps required to complete the upgrade process.
');
 script_set_attribute(attribute:"see_also", value: "http://rhn.redhat.com/errata/RHSA-2002-251.html");
 script_set_attribute(attribute:"solution", value: "Get the newest RedHat updates.");
 script_set_attribute(attribute:"cvss_vector", value:"CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
 script_end_attributes();
 
 script_summary(english: "Check for the version of the apache packages"); 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks"); 
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");
if ( rpm_check( reference:"apache-1.3.27-2", release:"RHEL2.1") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"apache-devel-1.3.27-2", release:"RHEL2.1") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"apache-manual-1.3.27-2", release:"RHEL2.1") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mod_ssl-2.8.12-2", release:"RHEL2.1") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}

exit(0, "Host is not affected");
