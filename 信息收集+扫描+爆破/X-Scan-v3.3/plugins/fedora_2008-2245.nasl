
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2008-2245
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(31369);
 script_version ("$Revision: 1.3 $");
script_name(english: "Fedora 7 2008-2245: mediawiki");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2008-2245 (mediawiki)");
 script_set_attribute(attribute: "description", value: "MediaWiki is the software used for Wikipedia and the other Wikimedia
Foundation websites. Compared to other wikis, it has an excellent
range of features and support for high-traffic websites using multiple
servers

This package supports wiki farms. Copy /var/www/wiki over to the
desired wiki location and configure it through the web
interface. Remember to remove the config dir after completing the
configuration.

-
References:

[ 1 ] Bug #430286 - CVE-2008-0460 Multiple MediaWiki XSS vulnerabilities
[9]https://bugzilla.redhat.com/show_bug.cgi?id=430286
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2008-0460");
script_summary(english: "Check for the version of the mediawiki package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"mediawiki-1.10.4-38.fc7", release:"FC7") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
