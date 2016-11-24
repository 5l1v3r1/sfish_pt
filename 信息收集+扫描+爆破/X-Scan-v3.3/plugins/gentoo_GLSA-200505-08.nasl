# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200505-08.xml
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
 script_id(18234);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200505-08");
 script_cve_id("CVE-2005-1545", "CVE-2005-1546");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200505-08 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200505-08
(HT Editor: Multiple buffer overflows)


    Tavis Ormandy of the Gentoo Linux Security Team discovered an integer
    overflow in the ELF parser, leading to a heap-based buffer overflow.
    The vendor has reported that an unrelated buffer overflow has been
    discovered in the PE parser.
  
Impact

    Successful exploitation would require the victim to open a specially
    crafted file using HT, potentially permitting an attacker to execute
    arbitrary code.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All hteditor users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-editors/hteditor-0.8.0-r2"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2005-1545');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2005-1546');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200505-08.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200505-08] HT Editor: Multiple buffer overflows');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'HT Editor: Multiple buffer overflows');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "app-editors/hteditor", unaffected: make_list("ge 0.8.0-r2"), vulnerable: make_list("lt 0.8.0-r2")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
