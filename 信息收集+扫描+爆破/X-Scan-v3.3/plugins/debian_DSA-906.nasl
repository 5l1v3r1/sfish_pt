# This script was automatically generated from the dsa-906
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(22772);
 script_version("$Revision: 1.4 $");
 script_xref(name: "DSA", value: "906");
 script_cve_id("CVE-2005-3354");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-906 security update');
 script_set_attribute(attribute: 'description', value:
'Colin Leroy discovered several buffer overflows in a number of
importer routines in sylpheed, a light-weight e-mail client with GTK+,
that could lead to the execution of arbitrary code.
The following matrix explains which versions fix this vulnerability
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2005/dsa-906');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your sylpheed package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA906] DSA-906-1 sylpheed");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-906-1 sylpheed");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'sylpheed', release: '3.0', reference: '0.7.4-4woody1');
deb_check(prefix: 'sylpheed-doc', release: '3.0', reference: '0.7.4-4woody1');
deb_check(prefix: 'sylpheed', release: '3.1', reference: '1.0.4-1sarge1');
deb_check(prefix: 'sylpheed-i18n', release: '3.1', reference: '1.0.4-1sarge1');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
