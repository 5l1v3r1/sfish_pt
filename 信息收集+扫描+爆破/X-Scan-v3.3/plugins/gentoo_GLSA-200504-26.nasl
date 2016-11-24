# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200504-26.xml
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
 script_id(18144);
 script_version("$Revision: 1.6 $");
 script_xref(name: "GLSA", value: "200504-26");
 script_cve_id("CVE-2005-1349");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200504-26 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200504-26
(Convert-UUlib: Buffer overflow)


    A vulnerability has been reported in Convert-UUlib where a malformed
    parameter can be provided by an attacker allowing a read operation to
    overflow a buffer. The vendor credits Mark Martinec and Robert Lewis
    with the discovery.
  
Impact

    Successful exploitation would permit an attacker to run arbitrary code
    with the privileges of the user running the Perl application.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Convert-UUlib users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-perl/Convert-UUlib-1.051"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2005-1349');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200504-26.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200504-26] Convert-UUlib: Buffer overflow');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Convert-UUlib: Buffer overflow');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-perl/Convert-UUlib", unaffected: make_list("ge 1.051"), vulnerable: make_list("lt 1.051")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
