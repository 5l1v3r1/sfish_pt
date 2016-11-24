# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200407-20.xml
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
 script_id(14553);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200407-20");
 script_cve_id("CVE-2004-1438");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200407-20 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200407-20
(Subversion: Vulnerability in mod_authz_svn)


    Users with write access to part of a Subversion repository may bypass
    read restrictions on any part of that repository. This can be done
    using an "svn copy" command to copy the portion of a repository the
    user wishes to read into an area where they have write access.
    Since copies are versioned, any such copy attempts will be readily
    apparent.
  
Impact

    This is a low-risk vulnerability. It affects only users of Subversion
    who are running servers inside Apache and using mod_authz_svn.
    Additionally, this vulnerability may be exploited only by users with
    write access to some portion of a repository.
  
Workaround

    Keep sensitive content separated into different Subversion
    repositories, or disable the Apache Subversion server and use svnserve
    instead.
  
');
script_set_attribute(attribute:'solution', value: '
    All Subversion users should upgrade to the latest available version:
    # emerge sync
    # emerge -pv ">=dev-util/subversion-1.0.6"
    # emerve ">=dev-util/subversion-1.0.6"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:P/I:N/A:N');
script_set_attribute(attribute: 'see_also', value: 'http://svn.collab.net/repos/svn/tags/1.0.6/CHANGES');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2004-1438');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200407-20.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200407-20] Subversion: Vulnerability in mod_authz_svn');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Subversion: Vulnerability in mod_authz_svn');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-util/subversion", unaffected: make_list("ge 1.0.6"), vulnerable: make_list("le 1.0.4-r1")
)) { security_note(0); exit(0); }
exit(0, "Host is not affected");
