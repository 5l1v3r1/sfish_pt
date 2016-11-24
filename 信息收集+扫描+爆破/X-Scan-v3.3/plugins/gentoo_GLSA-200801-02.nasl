# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200801-02.xml
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
 script_id(29906);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200801-02");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200801-02 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200801-02
(R: Multiple vulnerabilities)


    R includes a copy of PCRE which is vulnerable to multiple buffer
    overflows and memory corruptions vulnerabilities (GLSA 200711-30).
  
Impact

    An attacker could entice a user to process specially crafted regular
    expressions with R, which could possibly lead to the execution of
    arbitrary code, a Denial of Service or the disclosure of sensitive
    information.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All R users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-lang/R-2.2.1-r1"
  ');
script_set_attribute(attribute: 'risk_factor', value: 'Medium');
script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200711-30.xml');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200801-02.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200801-02] R: Multiple vulnerabilities');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'R: Multiple vulnerabilities');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-lang/R", unaffected: make_list("ge 2.2.1-r1"), vulnerable: make_list("lt 2.2.1-r1")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
