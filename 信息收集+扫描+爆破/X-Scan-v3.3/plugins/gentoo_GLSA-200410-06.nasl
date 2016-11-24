# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200410-06.xml
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
 script_id(15444);
 script_version("$Revision: 1.7 $");
 script_xref(name: "GLSA", value: "200410-06");
 script_cve_id("CVE-2004-0923");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200410-06 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200410-06
(CUPS: Leakage of sensitive information)


    When printing to a SMB-shared printer requiring authentication, CUPS leaks
    the user name and password to a logfile.
  
Impact

    A local user could gain knowledge of sensitive authentication data.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All CUPS users should upgrade to the latest version:
    # emerge sync
    # emerge -pv ">=net-print/cups-1.1.20-r3"
    # emerge ">=net-print/cups-1.1.20-r3"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:P/I:N/A:N');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2004-0923');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200410-06.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200410-06] CUPS: Leakage of sensitive information');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'CUPS: Leakage of sensitive information');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-print/cups", unaffected: make_list("rge 1.1.20-r3", "ge 1.1.21-r1"), vulnerable: make_list("le 1.1.20-r2", "eq 1.1.21")
)) { security_note(0); exit(0); }
exit(0, "Host is not affected");
