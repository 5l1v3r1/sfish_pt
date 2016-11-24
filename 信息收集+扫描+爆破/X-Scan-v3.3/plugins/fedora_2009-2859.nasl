
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2009-2859
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(36233);
 script_version ("$Revision: 1.2 $");
script_name(english: "Fedora 10 2009-2859: weechat");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2009-2859 (weechat)");
 script_set_attribute(attribute: "description", value: "WeeChat (Wee Enhanced Environment for Chat) is a portable, fast, light and
extensible IRC client. Everything can be done with a keyboard.
It is customizable and extensible with scripts.

-
ChangeLog:


Update information :

* Thu Mar 19 2009 Paul P. Komkoff Jr <i stingr net> - 0.2.6.1-1
- fix bz#490709
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2009-0661");
script_summary(english: "Check for the version of the weechat package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"weechat-0.2.6.1-1.fc10", release:"FC10") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
