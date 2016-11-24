# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200506-24.xml
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
 script_id(18590);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200506-24");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200506-24 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200506-24
(Heimdal: Buffer overflow vulnerabilities)


    It has been reported that the "getterminaltype" function of
    Heimdal\'s telnetd server is vulnerable to buffer overflows.
  
Impact

    An attacker could exploit this vulnerability to execute arbitrary
    code with the permission of the telnetd server program.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All users should upgrade to the latest available version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-crypt/heimdal-0.6.5"
  ');
script_set_attribute(attribute: 'risk_factor', value: 'High');
script_set_attribute(attribute: 'see_also', value: 'http://www.cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-2040');
script_set_attribute(attribute: 'see_also', value: 'http://www.pdc.kth.se/heimdal/advisory/2005-06-20/');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200506-24.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200506-24] Heimdal: Buffer overflow vulnerabilities');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Heimdal: Buffer overflow vulnerabilities');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "app-crypt/heimdal", unaffected: make_list("ge 0.6.5"), vulnerable: make_list("lt 0.6.5")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
