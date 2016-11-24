# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200509-08.xml
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
 script_id(19687);
 script_version("$Revision: 1.6 $");
 script_xref(name: "GLSA", value: "200509-08");
 script_cve_id("CVE-2005-2491");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200509-08 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200509-08
(Python: Heap overflow in the included PCRE library)


    The "re" Python module makes use of a private copy of libpcre
    which is subject to an integer overflow leading to a heap overflow (see
    GLSA 200508-17).
  
Impact

    An attacker could target a Python-based web application (or SUID
    application) that would use untrusted data as regular expressions,
    potentially resulting in the execution of arbitrary code (or privilege
    escalation).
  
Workaround

    Python users that don\'t run any Python web application or SUID
    application (or that run one that wouldn\'t use untrusted inputs as
    regular expressions) are not affected by this issue.
  
');
script_set_attribute(attribute:'solution', value: '
    All Python users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-lang/python-2.3.5-r2"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-2491');
script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200508-17.xml');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200509-08.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200509-08] Python: Heap overflow in the included PCRE library');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Python: Heap overflow in the included PCRE library');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-lang/python", unaffected: make_list("ge 2.3.5-r2"), vulnerable: make_list("lt 2.3.5-r2")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
