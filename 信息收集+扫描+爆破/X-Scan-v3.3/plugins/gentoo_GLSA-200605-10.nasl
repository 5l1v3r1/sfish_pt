# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200605-10.xml
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
 script_id(21352);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200605-10");
 script_cve_id("CVE-2006-2076", "CVE-2006-2077");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200605-10 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200605-10
(pdnsd: Denial of Service and potential arbitrary code execution)


    The pdnsd team has discovered an unspecified buffer overflow
    vulnerability. The PROTOS DNS Test Suite, by the Oulu University Secure
    Programming Group (OUSPG), has also revealed a memory leak error within
    the handling of the QTYPE and QCLASS DNS queries, leading to
    consumption of large amounts of memory.
  
Impact

    An attacker can craft malicious DNS queries leading to a Denial of
    Service, and potentially the execution of arbitrary code.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All pdnsd users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=net-dns/pdnsd-1.2.4-r1"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-2076');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-2077');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200605-10.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200605-10] pdnsd: Denial of Service and potential arbitrary code execution');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'pdnsd: Denial of Service and potential arbitrary code execution');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-dns/pdnsd", unaffected: make_list("ge 1.2.4"), vulnerable: make_list("lt 1.2.4")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
