# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200710-08.xml
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
 script_id(26979);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200710-08");
 script_cve_id("CVE-2007-3387");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200710-08 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200710-08
(KOffice, KWord, KPDF, KDE Graphics Libraries: Stack-based buffer overflow)


    KPDF includes code from xpdf that is vulnerable to an integer overflow
    in the StreamPredictor::StreamPredictor() function.
  
Impact

    A remote attacker could entice a user to open a specially crafted PDF
    file in KWord or KPDF that would exploit the integer overflow to cause
    a stack-based buffer overflow in the StreamPredictor::getNextLine()
    function, possibly resulting in the execution of arbitrary code with
    the privileges of the user running the application.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All KOffice users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-office/koffice-1.6.3-r1"
    All KWord users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-office/kword-1.6.3-r1"
    All KDE Graphics Libraries users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=kde-base/kdegraphics-3.5.7-r1"
    All KPDF users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=kde-base/kpdf-3.5.7-r1"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-3387');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200710-08.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200710-08] KOffice, KWord, KPDF, KDE Graphics Libraries: Stack-based buffer overflow');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'KOffice, KWord, KPDF, KDE Graphics Libraries: Stack-based buffer overflow');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "kde-base/kdegraphics", unaffected: make_list("ge 3.5.7-r1"), vulnerable: make_list("lt 3.5.7-r1")
)) { security_warning(0); exit(0); }
if (qpkg_check(package: "app-office/kword", unaffected: make_list("ge 1.6.3-r1"), vulnerable: make_list("lt 1.6.3-r1")
)) { security_warning(0); exit(0); }
if (qpkg_check(package: "kde-base/kpdf", unaffected: make_list("ge 3.5.7-r1"), vulnerable: make_list("lt 3.5.7-r1")
)) { security_warning(0); exit(0); }
if (qpkg_check(package: "app-office/koffice", unaffected: make_list("ge 1.6.3-r1"), vulnerable: make_list("lt 1.6.3-r1")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
