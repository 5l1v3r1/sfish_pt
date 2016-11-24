# This script was automatically generated from the dsa-155
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(14992);
 script_version("$Revision: 1.9 $");
 script_xref(name: "DSA", value: "155");
 script_cve_id("CVE-2002-0970");
 script_bugtraq_id(5410);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-155 security update');
 script_set_attribute(attribute: 'description', value:
'Due to a security engineering oversight, the SSL library from KDE,
which Konqueror uses, doesn\'t check whether an intermediate
certificate for a connection is signed by the certificate authority as
safe for the purpose, but accepts it when it is signed.  This makes it
possible for anyone with a valid VeriSign SSL site certificate to
forge any other VeriSign SSL site certificate, and abuse Konqueror
users.
A local root exploit using artsd has been discovered which exploited
an insecure use of a format string.  The exploit wasn\'t working on a
Debian system since artsd wasn\'t running setuid root.  Neither artsd
nor artswrapper need to be setuid root anymore since current computer
systems are fast enough to handle the audio data in time.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2002/dsa-155');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your kdelibs and libarts packages and
restart Konqueror.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA155] DSA-155-1 kdelibs");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-155-1 kdelibs");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'kdelibs-dev', release: '3.0', reference: '2.2.2-13.woody.2');
deb_check(prefix: 'kdelibs3', release: '3.0', reference: '2.2.2-13.woody.2');
deb_check(prefix: 'kdelibs3-bin', release: '3.0', reference: '2.2.2-13.woody.2');
deb_check(prefix: 'kdelibs3-cups', release: '3.0', reference: '2.2.2-13.woody.2');
deb_check(prefix: 'kdelibs3-doc', release: '3.0', reference: '2.2.2-13.woody.2');
deb_check(prefix: 'libarts', release: '3.0', reference: '2.2.2-13.woody.2');
deb_check(prefix: 'libarts-alsa', release: '3.0', reference: '2.2.2-13.woody.2');
deb_check(prefix: 'libarts-dev', release: '3.0', reference: '2.2.2-13.woody.2');
deb_check(prefix: 'libkmid', release: '3.0', reference: '2.2.2-13.woody.2');
deb_check(prefix: 'libkmid-alsa', release: '3.0', reference: '2.2.2-13.woody.2');
deb_check(prefix: 'libkmid-dev', release: '3.0', reference: '2.2.2-13.woody.2');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
