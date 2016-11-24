# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200612-01.xml
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
 script_id(23795);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200612-01");
 script_cve_id("CVE-2006-4513");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200612-01 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200612-01
(wv library: Multiple integer overflows)


    The wv library fails to do proper arithmetic checks in multiple places,
    possibly leading to integer overflows.
  
Impact

    An attacker could craft a malicious file that, when handled with the wv
    library, could lead to the execution of arbitrary code with the
    permissions of the user running the application.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All wv library users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-text/wv-1.2.3-r1"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-4513');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200612-01.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200612-01] wv library: Multiple integer overflows');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'wv library: Multiple integer overflows');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "app-text/wv", unaffected: make_list("ge 1.2.3-r1"), vulnerable: make_list("lt 1.2.3-r1")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
