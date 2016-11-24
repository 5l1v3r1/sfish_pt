# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200809-12.xml
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
 script_id(34258);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200809-12");
 script_cve_id("CVE-2008-3907");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200809-12 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200809-12
(Newsbeuter: User-assisted execution of arbitrary code)


    J.H.M. Dassen reported that the open-in-browser command does not
    properly escape shell metacharacters in the URL before passing it to
    system().
  
Impact

    A remote attacker could entice a user to open a feed with specially
    crafted URLs, possibly resulting in the remote execution of arbitrary
    shell commands with the privileges of the user running the application.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Newsbeuter users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=net-news/newsbeuter-1.2"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-3907');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200809-12.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200809-12] Newsbeuter: User-assisted execution of arbitrary code');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Newsbeuter: User-assisted execution of arbitrary code');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-news/newsbeuter", unaffected: make_list("ge 1.2"), vulnerable: make_list("lt 1.2")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
