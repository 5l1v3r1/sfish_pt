# This script was automatically generated from the dsa-1708
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(35425);
 script_version("$Revision: 1.3 $");
 script_xref(name: "DSA", value: "1708");
 script_cve_id("CVE-2008-5516", "CVE-2008-5517", "CVE-2008-5916");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1708 security update');
 script_set_attribute(attribute: 'description', value:
'It was discovered that gitweb, the web interface for the Git version
control system, contained several vulnerabilities:
Remote attackers could use crafted requests to execute shell commands on
the web server, using the snapshot generation and pickaxe search
functionality (CVE-2008-5916).
Local users with write access to the configuration of a Git repository
served by gitweb could cause gitweb to execute arbitrary shell commands
with the permission of the web server (CVE-2008-5516, CVE-2008-5517).
For the stable distribution (etch), these problems have been fixed in
version 1.4.4.4-4+etch1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2009/dsa-1708');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your Git packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1708] DSA-1708-1 git-core");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1708-1 git-core");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'git-arch', release: '4.0', reference: '1.4.4.4-4+etch1');
deb_check(prefix: 'git-core', release: '4.0', reference: '1.4.4.4-4+etch1');
deb_check(prefix: 'git-cvs', release: '4.0', reference: '1.4.4.4-4+etch1');
deb_check(prefix: 'git-daemon-run', release: '4.0', reference: '1.4.4.4-4+etch1');
deb_check(prefix: 'git-doc', release: '4.0', reference: '1.4.4.4-4+etch1');
deb_check(prefix: 'git-email', release: '4.0', reference: '1.4.4.4-4+etch1');
deb_check(prefix: 'git-svn', release: '4.0', reference: '1.4.4.4-4+etch1');
deb_check(prefix: 'gitk', release: '4.0', reference: '1.4.4.4-4+etch1');
deb_check(prefix: 'gitweb', release: '4.0', reference: '1.4.4.4-4+etch1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
