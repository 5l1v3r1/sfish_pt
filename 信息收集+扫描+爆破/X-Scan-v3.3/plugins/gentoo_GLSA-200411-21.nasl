# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200411-21.xml
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
 script_id(15696);
 script_version("$Revision: 1.7 $");
 script_xref(name: "GLSA", value: "200411-21");
 script_cve_id("CVE-2004-0930", "CVE-2004-0882");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200411-21 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200411-21
(Samba: Multiple vulnerabilities)


    Samba fails to do proper bounds checking when handling
    TRANSACT2_QFILEPATHINFO replies. Additionally an input validation flaw
    exists in ms_fnmatch.c when matching filenames that contain wildcards.
  
Impact

    An attacker may be able to execute arbitrary code with the permissions
    of the user running Samba. A remote attacker may also be able to cause
    an abnormal consumption of CPU resources, resulting in slower
    performance of the server or even a Denial of Service.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Samba users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=net-fs/samba-3.0.8"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://www.samba.org/samba/security/CAN-2004-0930.html');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2004-0930');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2004-0882');
script_set_attribute(attribute: 'see_also', value: 'http://security.e-matters.de/advisories/132004.html');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200411-21.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200411-21] Samba: Multiple vulnerabilities');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Samba: Multiple vulnerabilities');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-fs/samba", unaffected: make_list("ge 3.0.8", "lt 3.0"), vulnerable: make_list("lt 3.0.8")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
