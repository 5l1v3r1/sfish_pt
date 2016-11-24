# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200612-16.xml
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
 script_id(23873);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200612-16");
 script_cve_id("CVE-2006-5925");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200612-16 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200612-16
(Links: Arbitrary Samba command execution)


    Teemu Salmela discovered that Links does not properly validate "smb://"
    URLs when it runs smbclient commands.
  
Impact

    A remote attacker could entice a user to browse to a specially crafted
    "smb://" URL and execute arbitrary Samba commands, which would allow
    the overwriting of arbitrary local files or the upload or the download
    of arbitrary files. This vulnerability can be exploited only if
    "smbclient" is installed on the victim\'s computer, which is provided by
    the "samba" Gentoo package.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Links users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=www-client/links-2.1_pre26"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-5925');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200612-16.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200612-16] Links: Arbitrary Samba command execution');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Links: Arbitrary Samba command execution');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "www-client/links", unaffected: make_list("ge 2.1_pre26"), vulnerable: make_list("lt 2.1_pre26")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
