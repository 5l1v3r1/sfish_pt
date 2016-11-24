
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2008-2278
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(31372);
 script_version ("$Revision: 1.3 $");
script_name(english: "Fedora 8 2008-2278: lighttpd");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2008-2278 (lighttpd)");
 script_set_attribute(attribute: "description", value: "Secure, fast, compliant and very flexible web-server which has been optimized
for high-performance environments. It has a very low memory footprint compared
to other webservers and takes care of cpu-load. Its advanced feature-set
(FastCGI, CGI, Auth, Output-Compression, URL-Rewriting and many more) make
it the perfect webserver-software for every server that is suffering load
problems.

Available rpmbuild rebuild options :
--with : gamin webdavprops webdavlocks memcache
--without : ldap gdbm lua (cml)

-
ChangeLog:


Update information :

* Tue Mar  4 2008 Matthias Saou <[9]http://freshrpms.net/> 1.4.18-6
- Include patch for CVE-2008-0983 (crash when low on file descriptors).
- Include patch for CVE-2008-1111 (cgi source disclosure).
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2008-0983", "CVE-2008-1111");
script_summary(english: "Check for the version of the lighttpd package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"lighttpd-1.4.18-6.fc8", release:"FC8") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
