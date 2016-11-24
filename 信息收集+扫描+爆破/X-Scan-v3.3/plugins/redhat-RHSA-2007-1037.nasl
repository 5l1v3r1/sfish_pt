
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(27853);
 script_version ("$Revision: 1.4 $");
 script_name(english: "RHSA-2007-1037: compat");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2007-1037");
 script_set_attribute(attribute: "description", value: '
  Updated openldap packages that fix a security flaw are now available for
  Red Hat Enterprise Linux 5.

  This update has been rated as having important security impact by the Red
  Hat Security Response Team.

  OpenLDAP is an open source suite of LDAP (Lightweight Directory Access
  Protocol) applications and development tools.

  A flaw was found in the way OpenLDAP\'s slapd daemon handled malformed
  objectClasses LDAP attributes. A local or remote attacker could create an
  LDAP request which could cause a denial of service by crashing slapd.
  (CVE-2007-5707)

  In addition, the following feature was added:
  * OpenLDAP client tools now have new option to configure their bind timeout.

  All users are advised to upgrade to these updated openldap packages, which
  contain a backported patch to correct this issue and provide this security
  enhancement.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:N/A:C");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2007-1037.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2007-5707");
script_summary(english: "Check for the version of the compat packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"compat-openldap-2.3.27_2.2.29-8.el5_1.1", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"openldap-2.3.27-8.el5_1.1", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"openldap-clients-2.3.27-8.el5_1.1", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"openldap-devel-2.3.27-8.el5_1.1", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"openldap-servers-2.3.27-8.el5_1.1", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"openldap-servers-sql-2.3.27-8.el5_1.1", release:'RHEL5') )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
