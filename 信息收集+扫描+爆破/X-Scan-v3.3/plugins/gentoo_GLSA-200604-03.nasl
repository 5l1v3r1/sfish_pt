# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200604-03.xml
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
 script_id(21196);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200604-03");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200604-03 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200604-03
(FreeRADIUS: Authentication bypass in EAP-MSCHAPv2 module)


    FreeRADIUS suffers from insufficient input validation in the
    EAP-MSCHAPv2 state machine.
  
Impact

    An attacker could cause the server to bypass authentication checks
    by manipulating the EAP-MSCHAPv2 client state machine.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All FreeRADIUS users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=net-dialup/freeradius-1.1.1"
  ');
script_set_attribute(attribute: 'risk_factor', value: 'Medium');
script_set_attribute(attribute: 'see_also', value: 'http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-1354');
script_set_attribute(attribute: 'see_also', value: 'http://www.freeradius.org/security.html');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200604-03.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200604-03] FreeRADIUS: Authentication bypass in EAP-MSCHAPv2 module');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'FreeRADIUS: Authentication bypass in EAP-MSCHAPv2 module');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-dialup/freeradius", unaffected: make_list("ge 1.1.1", "lt 1.0.0"), vulnerable: make_list("lt 1.1.1")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
