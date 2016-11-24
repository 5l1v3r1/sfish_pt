# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200603-23.xml
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
 script_id(21147);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200603-23");
 script_cve_id("CVE-2006-1390");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200603-23 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200603-23
(NetHack, Slash\'EM, Falcon\'s Eye: Local privilege escalation)


    NetHack, Slash\'EM and Falcon\'s Eye have been found to be incompatible
    with the system used for managing games on Gentoo Linux. As a result,
    they cannot be played securely on systems with multiple users.
  
Impact

    A local user who is a member of group "games" may be able to modify the
    state data used by NetHack, Slash\'EM or Falcon\'s Eye to trigger the
    execution of arbitrary code with the privileges of other players.
    Additionally, the games may create save game files in a manner not
    suitable for use on Gentoo Linux, potentially allowing a local user to
    create or overwrite files with the permissions of other players.
  
Workaround

    Do not add untrusted users to the "games" group.
  
');
script_set_attribute(attribute:'solution', value: '
    NetHack has been masked in Portage pending the resolution of these
    issues. Vulnerable NetHack users are advised to uninstall the package
    until further notice.
    # emerge --ask --verbose --unmerge "games-roguelike/nethack"
    Slash\'EM has been masked in Portage pending the resolution of these
    issues. Vulnerable Slash\'EM users are advised to uninstall the package
    until further notice.
    # emerge --ask --verbose --unmerge "games-roguelike/slashem"
    Falcon\'s Eye has been masked in Portage pending the resolution of these
    issues. Vulnerable Falcon\'s Eye users are advised to uninstall the
    package until further notice.
    # emerge --ask --verbose --unmerge "games-roguelike/falconseye"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-1390');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200603-23.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200603-23] NetHack, Slash\'EM, Falcon\'s Eye: Local privilege escalation');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'NetHack, Slash\'EM, Falcon\'s Eye: Local privilege escalation');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "games-roguelike/slashem", unaffected: make_list(), vulnerable: make_list("le 0.0.760")
)) { security_warning(0); exit(0); }
if (qpkg_check(package: "games-roguelike/nethack", unaffected: make_list(), vulnerable: make_list("le 3.4.3-r1")
)) { security_warning(0); exit(0); }
if (qpkg_check(package: "games-roguelike/falconseye", unaffected: make_list(), vulnerable: make_list("le 1.9.4a")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
