
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2008-3328
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(32092);
 script_version ("$Revision: 1.3 $");
script_name(english: "Fedora 7 2008-3328: moin");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2008-3328 (moin)");
 script_set_attribute(attribute: "description", value: "A WikiWikiWeb is a collaborative hypertext environment, with an emphasis on
easy access to and modification of information. MoinMoin is a Python
WikiClone that allows you to easily set up your own wiki, only requiring a
Web server and a Python installation.

-
Update Information:

This update fixes various security issues present in moin 1.5.8.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2008-0780", "CVE-2008-0781", "CVE-2008-1098", "CVE-2008-1099");
script_summary(english: "Check for the version of the moin package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"moin-1.5.9-1.fc7", release:"FC7") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
