# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200903-41.xml
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
 script_id(36055);
 script_version("$Revision: 1.3 $");
 script_xref(name: "GLSA", value: "200903-41");
 script_cve_id("CVE-2008-5983", "CVE-2009-0314");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200903-41 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200903-41
(gedit: Untrusted search path)


    James Vega reported that gedit uses the current working directory when
    searching for python modules, a vulnerability related to CVE-2008-5983.
  
Impact

    A local attacker could entice a user to open gedit from a specially
    crafted environment, possibly resulting in the execution of arbitrary
    code with the privileges of the user running the application.
  
Workaround

    Do not run gedit from untrusted working directories.
  
');
script_set_attribute(attribute:'solution', value: '
    All gedit 2.22.x users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-editors/gedit-2.22.3-r1"
    All gedit 2.24.x users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-editors/gedit-2.24.3"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:M/Au:N/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-5983');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2009-0314');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200903-41.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200903-41] gedit: Untrusted search path');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'gedit: Untrusted search path');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "app-editors/gedit", unaffected: make_list("rge 2.22.3-r1", "ge 2.24.3"), vulnerable: make_list("lt 2.24.3")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
