
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2009-9799
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(41612);
 script_version ("$Revision: 1.2 $");
script_name(english: "Fedora 10 2009-9799: rubygem-activesupport");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2009-9799 (rubygem-activesupport)");
 script_set_attribute(attribute: "description", value: "Utility library which carries commonly used classes and
goodies from the Rails framework

-
Update Information:

A vulnerability is found on Ruby on Rails in the escaping code for the form
helpers, which also affects the rpms shipped in Fedora Project. Attackers who
can inject deliberately malformed unicode strings into the form helpers can
defeat the escaping checks and inject arbitrary HTML. This issue has been tagge
d
as CVE-2009-3009.    These new rpms will fix this issue.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2009-3009");
script_summary(english: "Check for the version of the rubygem-activesupport package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"rubygem-activesupport-2.1.1-2.fc10", release:"FC10") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
