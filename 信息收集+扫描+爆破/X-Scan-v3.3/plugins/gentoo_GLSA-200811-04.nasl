# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200811-04.xml
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
 script_id(34735);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200811-04");
 script_cve_id("CVE-2008-4555");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200811-04 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200811-04
(Graphviz: User-assisted execution of arbitrary code)


    Roee Hay reported a stack-based buffer overflow in the push_subg()
    function in parser.y when processing a DOT file with a large number of
    Agraph_t elements.
  
Impact

    A remote attacker could entice a user or automated system to open a
    specially crafted DOT file in an application using Graphviz, possibly
    leading to the execution of arbitrary code.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Graphviz users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=media-gfx/graphviz-2.20.3"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:S/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-4555');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200811-04.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200811-04] Graphviz: User-assisted execution of arbitrary code');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Graphviz: User-assisted execution of arbitrary code');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "media-gfx/graphviz", unaffected: make_list("ge 2.20.3"), vulnerable: make_list("lt 2.20.3")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
