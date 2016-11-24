# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200703-11.xml
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
 script_id(24828);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200703-11");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200703-11 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200703-11
(Amarok: User-assisted remote execution of arbitrary code)


    The Magnatune downloader doesn\'t quote the "m_currentAlbumFileName"
    parameter while calling the "unzip" shell command.
  
Impact

    A compromised or malicious Magnatune server can remotely execute
    arbitrary shell code with the rights of the user running Amarok on a
    client that have previously registered for buying music.
  
Workaround

    Do not use the Magnatune component of Amarok.
  
');
script_set_attribute(attribute:'solution', value: '
    All Amarok users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=media-sound/amarok-1.4.5-r1"
  ');
script_set_attribute(attribute: 'risk_factor', value: 'Medium');
script_set_attribute(attribute: 'see_also', value: 'http://secunia.com/advisories/24159');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200703-11.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200703-11] Amarok: User-assisted remote execution of arbitrary code');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Amarok: User-assisted remote execution of arbitrary code');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "media-sound/amarok", unaffected: make_list("ge 1.4.5-r1"), vulnerable: make_list("lt 1.4.5-r1")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
