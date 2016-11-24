# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200406-20.xml
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
 script_id(14531);
 script_version("$Revision: 1.6 $");
 script_xref(name: "GLSA", value: "200406-20");
 script_cve_id("CVE-2004-0590");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200406-20 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200406-20
(FreeS/WAN, Openswan, strongSwan: Vulnerabilities in certificate handling)


    All these IPsec implementations have several bugs in the
    verify_x509cert() function, which performs certificate validation, that
    make them vulnerable to malicious PKCS#7 wrapped objects.
  
Impact

    With a carefully crafted certificate payload an attacker can
    successfully authenticate against FreeS/WAN, Openswan, strongSwan or
    Super-FreeS/WAN, or make the daemon go into an endless loop.
  
Workaround

    There is no known workaround at this time. All users are encouraged to
    upgrade to the latest available version.
  
');
script_set_attribute(attribute:'solution', value: '
    All FreeS/WAN 1.9x users should upgrade to the latest stable version:
    # emerge sync
    # emerge -pv "=net-misc/freeswan-1.99-r1"
    # emerge "=net-misc/freeswan-1.99-r1"
    All FreeS/WAN 2.x users should upgrade to the latest stable version:
    # emerge sync
    # emerge -pv ">=net-misc/freeswan-2.04-r1"
    # emerge ">=net-misc/freeswan-2.04-r1"
    All Openswan 1.x users should upgrade to the latest stable version:
    # emerge sync
    # emerge -pv "=net-misc/openswan-1.0.6_rc1"
    # emerge "=net-misc/openswan-1.0.6_rc1"
    All Openswan 2.x users should upgrade to the latest stable version:
    # emerge sync
    # emerge -pv ">=net-misc/openswan-2.1.4"
    # emerge ">=net-misc/openswan-2.1.4"
    All strongSwan users should upgrade to the latest stable version:
    # emerge sync
    # emerge -pv ">=net-misc/strongswan-2.1.3"
    # emerge ">=net-misc/strongswan-2.1.3"
    All Super-FreeS/WAN users should migrate to the latest stable version
    of Openswan. Note that Portage will force a move for Super-FreeS/WAN
    users to Openswan.
    # emerge sync
    # emerge -pv "=net-misc/openswan-1.0.6_rc1"
    # emerge "=net-misc/openswan-1.0.6_rc1"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://lists.openswan.org/pipermail/dev/2004-June/000370.html');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2004-0590');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200406-20.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200406-20] FreeS/WAN, Openswan, strongSwan: Vulnerabilities in certificate handling');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'FreeS/WAN, Openswan, strongSwan: Vulnerabilities in certificate handling');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-misc/openswan", unaffected: make_list("ge 2.1.4", "eq 1.0.6_rc1"), vulnerable: make_list("lt 2.1.4")
)) { security_hole(0); exit(0); }
if (qpkg_check(package: "net-misc/super-freeswan", unaffected: make_list(), vulnerable: make_list("le 1.99.7.3")
)) { security_hole(0); exit(0); }
if (qpkg_check(package: "net-misc/strongswan", unaffected: make_list("ge 2.1.3"), vulnerable: make_list("lt 2.1.3")
)) { security_hole(0); exit(0); }
if (qpkg_check(package: "net-misc/freeswan", unaffected: make_list("ge 2.04-r1", "eq 1.99-r1"), vulnerable: make_list("lt 2.04-r1")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
