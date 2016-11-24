# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200710-29.xml
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
 script_id(27580);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200710-29");
 script_cve_id("CVE-2007-2958");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200710-29 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200710-29
(Sylpheed, Claws Mail: User-assisted remote execution of arbitrary code)


    Ulf Harnhammar from Secunia Research discovered a format string error
    in the inc_put_error() function in file src/inc.c.
  
Impact

    A remote attacker could entice a user to connect to a malicious POP
    server sending specially crafted replies, possibly resulting in the
    execution of arbitrary code with the privileges of the user running the
    application.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Sylpheed users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=mail-client/sylpheed-2.4.5"
    All Claws Mail users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=mail-client/claws-mail-3.0.0"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-2958');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200710-29.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200710-29] Sylpheed, Claws Mail: User-assisted remote execution of arbitrary code');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Sylpheed, Claws Mail: User-assisted remote execution of arbitrary code');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "mail-client/sylpheed", unaffected: make_list("ge 2.4.5"), vulnerable: make_list("lt 2.4.5")
)) { security_warning(0); exit(0); }
if (qpkg_check(package: "mail-client/claws-mail", unaffected: make_list("ge 3.0.0"), vulnerable: make_list("lt 3.0.0")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
