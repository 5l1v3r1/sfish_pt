# This script was automatically generated from the dsa-1133
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(22675);
 script_version("$Revision: 1.6 $");
 script_xref(name: "DSA", value: "1133");
 script_cve_id("CVE-2006-0664", "CVE-2006-0665", "CVE-2006-0841", "CVE-2006-1577");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1133 security update');
 script_set_attribute(attribute: 'description', value:
'Several remote vulnerabilities have been discovered in the Mantis bug
tracking system, which may lead to the execution of arbitrary web script.
The Common Vulnerabilities and Exposures project identifies the following
problems:
CVE-2006-0664
    A cross-site scripting vulnerability was discovered in
    config_defaults_inc.php.
CVE-2006-0665
    Cross-site scripting vulnerabilities were discovered in query_store.php
    and manage_proj_create.php.
CVE-2006-0841
    Multiple cross-site scripting vulnerabilities were discovered in
    view_all_set.php, manage_user_page.php, view_filters_page.php and
    proj_doc_delete.php.
CVE-2006-1577
    Multiple cross-site scripting vulnerabilities were discovered in
    view_all_set.php.
For the stable distribution (sarge) these problems have been fixed in
version 0.19.2-5sarge4.1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2006/dsa-1133');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your mantis package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1133] DSA-1133-1 mantis");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1133-1 mantis");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'mantis', release: '3.1', reference: '0.19.2-5sarge4.1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
