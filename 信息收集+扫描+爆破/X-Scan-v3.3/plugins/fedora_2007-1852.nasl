
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2007-1852
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(27737);
 script_version ("$Revision: 1.3 $");
script_name(english: "Fedora 7 2007-1852: star");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2007-1852 (star)");
 script_set_attribute(attribute: "description", value: "Star saves many files together into a single tape or disk archive,
and can restore individual files from the archive. Star supports ACL.

-
ChangeLog:


Update information :

* Mon Aug 27 2007 Peter Vrabec <pvrabec redhat com> 1.5a84-2
- fix segfault of data-change-warn option (#255261),
patch from dkopecek redhat com
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2007-4134");
script_summary(english: "Check for the version of the star package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"star-1.5a84-2.fc7", release:"FC7") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
