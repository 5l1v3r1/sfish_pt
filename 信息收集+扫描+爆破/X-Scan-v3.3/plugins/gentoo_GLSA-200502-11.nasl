# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200502-11.xml
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
 script_id(16448);
 script_version("$Revision: 1.6 $");
 script_xref(name: "GLSA", value: "200502-11");
 script_cve_id("CVE-2005-0202");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200502-11 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200502-11
(Mailman: Directory traversal vulnerability)


    Mailman contains an error in private.py which fails to properly
    sanitize input paths.
  
Impact

    An attacker could exploit this flaw to obtain arbitrary files on
    the web server.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Mailman users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=net-mail/mailman-2.1.5-r4"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N');
script_set_attribute(attribute: 'see_also', value: 'http://lists.netsys.com/pipermail/full-disclosure/2005-February/031562.html');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0202');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200502-11.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200502-11] Mailman: Directory traversal vulnerability');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Mailman: Directory traversal vulnerability');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-mail/mailman", unaffected: make_list("ge 2.1.5-r4"), vulnerable: make_list("lt 2.1.5-r4")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
