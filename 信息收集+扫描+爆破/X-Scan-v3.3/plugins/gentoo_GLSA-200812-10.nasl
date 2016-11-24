# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200812-10.xml
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
 script_id(35085);
 script_version("$Revision: 1.3 $");
 script_xref(name: "GLSA", value: "200812-10");
 script_cve_id("CVE-2007-4829");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200812-10 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200812-10
(Archive::Tar: Directory traversal vulnerability)


    Jonathan Smith of rPath reported that Archive::Tar does not check for
    ".." in file names.
  
Impact

    A remote attacker could entice a user or automated system to extract a
    specially crafted tar archive, overwriting files at arbitrary locations
    outside of the specified directory.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Archive::Tar users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=perl-core/Archive-Tar-1.40"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-4829');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200812-10.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200812-10] Archive::Tar: Directory traversal vulnerability');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Archive::Tar: Directory traversal vulnerability');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "perl-core/Archive-Tar", unaffected: make_list("ge 1.40"), vulnerable: make_list("lt 1.40")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
