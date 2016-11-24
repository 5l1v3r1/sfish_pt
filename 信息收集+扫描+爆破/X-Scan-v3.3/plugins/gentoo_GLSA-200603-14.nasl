# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200603-14.xml
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
 script_id(21095);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200603-14");
 script_cve_id("CVE-2006-0582");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200603-14 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200603-14
(Heimdal: rshd privilege escalation)


    An unspecified privilege escalation vulnerability in the rshd
    server of Heimdal has been reported.
  
Impact

    Authenticated users could exploit the vulnerability to escalate
    privileges or to change the ownership and content of arbitrary files.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Heimdal users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-crypt/heimdal-0.7.2"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:N/I:P/A:N');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-0582');
script_set_attribute(attribute: 'see_also', value: 'http://www.pdc.kth.se/heimdal/advisory/2006-02-06/');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200603-14.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200603-14] Heimdal: rshd privilege escalation');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Heimdal: rshd privilege escalation');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "app-crypt/heimdal", unaffected: make_list("ge 0.7.2"), vulnerable: make_list("lt 0.7.2")
)) { security_note(0); exit(0); }
exit(0, "Host is not affected");
