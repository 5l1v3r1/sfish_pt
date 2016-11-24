# This script was automatically generated from the dsa-079
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(14916);
 script_version("$Revision: 1.8 $");
 script_xref(name: "DSA", value: "079");
 script_cve_id("CVE-2001-0873");
 script_bugtraq_id(3312);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-079 security update');
 script_set_attribute(attribute: 'description', value:
'Zenith Parsec discovered a security hole in Taylor UUCP 1.06.1.  It
permits a local user to copy any file to anywhere which is writable by
the uucp uid, which effectively means that a local user can completely
subvert the UUCP subsystem, including stealing mail, etc.
If a remote user with UUCP access is able to create files on the local
system, and can successfully make certain guesses about the local
directory structure layout, then the remote user can also subvert the
UUCP system.  A default installation of UUCP will permit a remote user
to create files on the local system if the UUCP public directory has
been created with world write permissions.
Obviously this security hole is serious for anybody who uses UUCP on a
multi-user system with untrusted users, or anybody who uses UUCP and
permits connections from untrusted remote systems.
It was thought that this problem has been fixed with DSA 079-1, but
that didn\'t fix all variations of the problem.  The problem is fixed
in version 1.06.1-11potato2 of uucp which uses a patch from the
upstream author Ian Lance Taylor.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2001/dsa-079');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your uucp package immediately.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA079] DSA-079-2 uucp");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-079-2 uucp");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'uucp', release: '2.2', reference: '1.06.1-11potato2');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
