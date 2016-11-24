# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200403-01.xml
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
 script_id(14452);
 script_version("$Revision: 1.7 $");
 script_xref(name: "GLSA", value: "200403-01");
 script_cve_id("CVE-2004-0110");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200403-01 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200403-01
(Libxml2 URI Parsing Buffer Overflow Vulnerabilities)


    Yuuichi Teranishi discovered a flaw in libxml2 versions prior to 2.6.6.
    When the libxml2 library fetches a remote resource via FTP or HTTP, libxml2
    uses parsing routines that can overflow a buffer caused by improper bounds
    checking if they are passed a URL longer than 4096 bytes.
  
Impact

    If an attacker is able to exploit an application using libxml2 that parses
    remote resources, then this flaw could be used to execute arbitrary code.
  
Workaround

    No workaround is available; users are urged to upgrade libxml2 to 2.6.6.
  
');
script_set_attribute(attribute:'solution', value: '
    All users are recommended to upgrade their libxml2 installation:
    # emerge sync
    # emerge -pv ">=dev-libs/libxml2-2.6.6"
    # emerge ">=dev-libs/libxml2-2.6.6"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2004-0110');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200403-01.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200403-01] Libxml2 URI Parsing Buffer Overflow Vulnerabilities');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Libxml2 URI Parsing Buffer Overflow Vulnerabilities');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-libs/libxml2", unaffected: make_list("ge 2.6.6"), vulnerable: make_list("lt 2.6.6")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
