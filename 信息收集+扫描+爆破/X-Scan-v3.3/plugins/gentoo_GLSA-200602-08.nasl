# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200602-08.xml
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
 script_id(20934);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200602-08");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200602-08 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200602-08
(libtasn1, GNU TLS: Security flaw in DER decoding)


    Evgeny Legerov has reported a flaw in the DER decoding routines
    provided by libtasn1, which could cause an out of bounds access to
    occur.
  
Impact

    A remote attacker could cause an application using libtasn1 to
    crash and potentially execute arbitrary code by sending specially
    crafted input.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All libtasn1 users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-libs/libtasn1-0.2.18"
    All GNU TLS users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=net-libs/gnutls-1.2.10"
  ');
script_set_attribute(attribute: 'risk_factor', value: 'High');
script_set_attribute(attribute: 'see_also', value: 'http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-0645');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200602-08.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200602-08] libtasn1, GNU TLS: Security flaw in DER decoding');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'libtasn1, GNU TLS: Security flaw in DER decoding');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-libs/libtasn1", unaffected: make_list("ge 0.2.18"), vulnerable: make_list("lt 0.2.18")
)) { security_hole(0); exit(0); }
if (qpkg_check(package: "net-libs/gnutls", unaffected: make_list("ge 1.2.10"), vulnerable: make_list("lt 1.2.10")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
