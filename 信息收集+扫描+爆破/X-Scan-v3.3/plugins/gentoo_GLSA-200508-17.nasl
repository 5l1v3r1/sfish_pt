# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200508-17.xml
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
 script_id(19537);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200508-17");
 script_cve_id("CVE-2005-2491");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200508-17 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200508-17
(libpcre: Heap integer overflow)


    libpcre fails to check certain quantifier values in regular
    expressions for sane values.
  
Impact

    An attacker could possibly exploit this vulnerability to execute
    arbitrary code by sending specially crafted regular expressions to
    applications making use of the libpcre library.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All libpcre users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-libs/libpcre-6.3"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-2491');
script_set_attribute(attribute: 'see_also', value: 'http://www.securitytracker.com/alerts/2005/Aug/1014744.html');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200508-17.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200508-17] libpcre: Heap integer overflow');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'libpcre: Heap integer overflow');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-libs/libpcre", unaffected: make_list("ge 6.3"), vulnerable: make_list("lt 6.3")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
