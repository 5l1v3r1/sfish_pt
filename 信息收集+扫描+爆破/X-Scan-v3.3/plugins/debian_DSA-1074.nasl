# This script was automatically generated from the dsa-1074
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(22616);
 script_version("$Revision: 1.6 $");
 script_xref(name: "DSA", value: "1074");
 script_cve_id("CVE-2006-1655");
 script_bugtraq_id(17365);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1074 security update');
 script_set_attribute(attribute: 'description', value:
'A. Alejandro Hernández discovered a vulnerability in mpg123, a
command-line player for MPEG audio files. Insufficient validation of
MPEG 2.0 layer 3 files results in several buffer overflows.
For the stable distribution (sarge) these problems have been fixed in
version 0.59r-20sarge1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2006/dsa-1074');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your mpg123 packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:S/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1074] DSA-1074-1 mpg123");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1074-1 mpg123");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'mpg123', release: '3.1', reference: '0.59r-20sarge1');
deb_check(prefix: 'mpg123-esd', release: '3.1', reference: '0.59r-20sarge1');
deb_check(prefix: 'mpg123-nas', release: '3.1', reference: '0.59r-20sarge1');
deb_check(prefix: 'mpg123-oss-3dnow', release: '3.1', reference: '0.59r-20sarge1');
deb_check(prefix: 'mpg123-oss-i486', release: '3.1', reference: '0.59r-20sarge1');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
