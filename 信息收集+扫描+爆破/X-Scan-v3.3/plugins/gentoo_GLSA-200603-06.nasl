# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200603-06.xml
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
 script_id(21044);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200603-06");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200603-06 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200603-06
(GNU tar: Buffer overflow)


    Jim Meyering discovered a flaw in the handling of certain header
    fields that could result in a buffer overflow when extracting or
    listing the contents of an archive.
  
Impact

    A remote attacker could construct a malicious tar archive that
    could potentially execute arbitrary code with the privileges of the
    user running GNU tar.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All GNU tar users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-arch/tar-1.15.1-r1"
  ');
script_set_attribute(attribute: 'risk_factor', value: 'Medium');
script_set_attribute(attribute: 'see_also', value: 'http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-0300');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200603-06.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200603-06] GNU tar: Buffer overflow');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'GNU tar: Buffer overflow');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "app-arch/tar", unaffected: make_list("ge 1.15.1-r1"), vulnerable: make_list("lt 1.15.1-r1")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
