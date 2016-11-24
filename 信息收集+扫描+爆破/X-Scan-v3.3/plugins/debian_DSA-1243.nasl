# This script was automatically generated from the dsa-1243
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(23948);
 script_version("$Revision: 1.6 $");
 script_xref(name: "DSA", value: "1243");
 script_cve_id("CVE-2006-5864");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1243 security update');
 script_set_attribute(attribute: 'description', value:
'Renaud Lifchitz discovered that gv, the PostScript and PDF viewer for X,
performs insufficient boundary checks in the Postscript parsing code,
which allows the execution of arbitrary code through a buffer overflow.
Evince embeds a copy of gv and needs an update as well.
For the stable distribution (sarge) this problem has been fixed in
version 0.1.5-2sarge1.
For the upcoming stable distribution (etch) this problem has been
fixed in version 0.4.0-3.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2006/dsa-1243');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your evince package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1243] DSA-1243-1 evince");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1243-1 evince");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'evince', release: '3.1', reference: '0.1.5-2sarge1');
deb_check(prefix: 'evince', release: '4.0', reference: '0.4.0-3');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
