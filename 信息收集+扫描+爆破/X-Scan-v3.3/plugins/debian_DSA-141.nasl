# This script was automatically generated from the dsa-141
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(14978);
 script_version("$Revision: 1.13 $");
 script_xref(name: "DSA", value: "141");
 script_bugtraq_id(5385);
 script_bugtraq_id(5386);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-141 security update');
 script_set_attribute(attribute: 'description', value:
'Eckehard Berns discovered a buffer overflow in the munpack program
which is used for decoding (respectively) binary files in MIME
(Multipurpose Internet Mail Extensions) format mail messages.  If
munpack is run on an appropriately malformed email (or news article)
then it will crash, and perhaps can be made to run arbitrary code.
Herbert Xu reported a second vulnerability which affected malformed
filenames that refer to files in upper directories like "../a".  The
security impact is limited, though, because only a single leading
"../" was accepted and only new files can be created (i.e. no files
will be overwritten).
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2002/dsa-141');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your mpack package immediately.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA141] DSA-141-1 mpack");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_cve_id("CVE-2002-1424", "CVE-2002-1425");
 script_summary(english: "DSA-141-1 mpack");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'mpack', release: '2.2', reference: '1.5-5potato2');
deb_check(prefix: 'mpack', release: '3.0', reference: '1.5-7woody2');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
