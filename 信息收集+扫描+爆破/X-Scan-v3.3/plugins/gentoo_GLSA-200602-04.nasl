# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200602-04.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2006 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description)
{
 script_id(20894);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200602-04");
 script_cve_id("CVE-2006-0301");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200602-04 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200602-04
(Xpdf, Poppler: Heap overflow)


    Dirk Mueller has reported a vulnerability in Xpdf. It is caused by
    a missing boundary check in the splash rasterizer engine when handling
    PDF splash images with overly large dimensions.
  
Impact

    By sending a specially crafted PDF file to a victim, an attacker
    could cause an overflow, potentially resulting in the execution of
    arbitrary code with the privileges of the user running the application.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Xpdf users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-text/xpdf-3.01-r7"
    All Poppler users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-text/poppler-0.5.0-r4"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-0301');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200602-04.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200602-04] Xpdf, Poppler: Heap overflow');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Xpdf, Poppler: Heap overflow');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "app-text/poppler", unaffected: make_list("ge 0.5.0-r4"), vulnerable: make_list("lt 0.5.0-r4")
)) { security_hole(0); exit(0); }
if (qpkg_check(package: "app-text/xpdf", unaffected: make_list("ge 3.01-r7"), vulnerable: make_list("lt 3.01-r7")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
