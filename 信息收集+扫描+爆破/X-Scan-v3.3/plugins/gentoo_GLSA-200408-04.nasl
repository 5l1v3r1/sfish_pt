# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200408-04.xml
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
 script_id(14560);
 script_version("$Revision: 1.6 $");
 script_xref(name: "GLSA", value: "200408-04");
 script_cve_id("CVE-2004-1440");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200408-04 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200408-04
(PuTTY: Pre-authentication arbitrary code execution)


    PuTTY contains a vulnerability allowing a malicious server to execute
    arbitrary code on the connecting client before host key verification.
  
Impact

    When connecting to a server using the SSH2 protocol an attacker is able
    to execute arbitrary code with the permissions of the user running
    PuTTY by sending specially crafted packets to the client during the
    authentication process but before host key verification.
  
Workaround

    There is no known workaround at this time. All users are encouraged to
    upgrade to the latest available version of PuTTY.
  
');
script_set_attribute(attribute:'solution', value: '
    All PuTTY users should upgrade to the latest version:
    # emerge sync
    # emerge -pv ">=net-misc/putty-0.55"
    # emerge ">=net-misc/putty-0.55"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://www.coresecurity.com/common/showdoc.php?idx=417&idxseccion=10');
script_set_attribute(attribute: 'see_also', value: 'http://www.chiark.greenend.org.uk/~sgtatham/putty/changes.html');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2004-1440');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200408-04.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200408-04] PuTTY: Pre-authentication arbitrary code execution');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'PuTTY: Pre-authentication arbitrary code execution');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-misc/putty", unaffected: make_list("ge 0.55"), vulnerable: make_list("le 0.54")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
