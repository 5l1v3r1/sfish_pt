
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(12453);
 script_version ("$Revision: 1.8 $");
 script_name(english: "RHSA-2004-023: net");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2004-023");
 script_set_attribute(attribute: "description", value: '
  Updated Net-SNMP packages are available to correct a security vulnerability
  and other bugs.

  The Net-SNMP project includes various Simple Network Management Protocol
  (SNMP) tools.

  A security issue in Net-SNMP versions before 5.0.9 could allow an existing
  user/community to gain access to data in MIB objects that were explicitly
  excluded from their view. The Common Vulnerabilities and Exposures project
  (cve.mitre.org) has assigned the name CAN-2003-0935 to this issue.

  Users of Net-SNMP are advised to upgrade to these errata packages containing
  Net-SNMP 5.0.9 which is not vulnerable to this issue. In addition,
  Net-SNMP 5.0.9 fixes a number of other minor bugs.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:N");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2004-023.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2003-0935");
script_summary(english: "Check for the version of the net packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"net-snmp-5.0.9-2.30E.1", release:'RHEL3') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"net-snmp-devel-5.0.9-2.30E.1", release:'RHEL3') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"net-snmp-utils-5.0.9-2.30E.1", release:'RHEL3') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
