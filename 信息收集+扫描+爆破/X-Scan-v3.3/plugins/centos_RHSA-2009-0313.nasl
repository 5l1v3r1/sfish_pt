#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if ( description )
{
 script_id(35767);
 script_version("$Revision: 1.2 $");
 script_name(english:"CentOS : RHSA-2009-0313");
 script_set_attribute(attribute: "synopsis", value: "The remote host is missing a security update.");
 script_set_attribute(attribute: "description", value: 
"The remote CentOS system is missing a security update which has been 
documented in Red Hat advisory RHSA-2009-0313.");
 script_set_attribute(attribute: "see_also", value:
"https://rhn.redhat.com/errata/RHSA-2009-0313.html");
 script_set_attribute(attribute: "solution", value:
"Upgrade to the newest packages by doing :

  yum update");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P");
script_end_attributes();

script_cve_id("CVE-2008-4680","CVE-2008-4681","CVE-2008-4682","CVE-2008-4683","CVE-2008-4684","CVE-2008-4685","CVE-2008-5285","CVE-2008-6472","CVE-2009-0599","CVE-2009-0600");

 script_summary(english:"Checks for missing updates on the remote CentOS system");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is (C) 2009 Tenable Network Security, Inc.");
 script_family(english:"CentOS Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/CentOS/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/CentOS/rpm-list") ) exit(1, "Could not obtain the list of packages");

if ( rpm_check(reference:"wireshark-1.0.6-EL3.3", release:"CentOS-3", cpu:"i386") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check(reference:"wireshark-gnome-1.0.6-EL3.3", release:"CentOS-3", cpu:"i386") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check(reference:"wireshark-1.0.6-EL3.3", release:"CentOS-3", cpu:"x86_64") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check(reference:"wireshark-gnome-1.0.6-EL3.3", release:"CentOS-3", cpu:"x86_64") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check(reference:"wireshark-1.0.6-2.c4", release:"CentOS-4", cpu:"ia64") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check(reference:"wireshark-gnome-1.0.6-2.c4", release:"CentOS-4", cpu:"ia64") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check(reference:"wireshark-1.0.6-EL3.3", release:"CentOS-3", cpu:"ia64") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check(reference:"wireshark-gnome-1.0.6-EL3.3", release:"CentOS-3", cpu:"ia64") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
