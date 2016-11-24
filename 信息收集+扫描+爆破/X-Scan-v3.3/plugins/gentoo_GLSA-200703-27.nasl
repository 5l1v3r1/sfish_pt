# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200703-27.xml
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
 script_id(24932);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200703-27");
 script_cve_id("CVE-2007-1560");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200703-27 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200703-27
(Squid: Denial of Service)


    Squid incorrectly handles TRACE requests that contain a "Max-Forwards"
    header field with value "0" in the clientProcessRequest() function.
  
Impact

    A remote attacker can send specially crafted TRACE HTTP requests that
    will terminate the child process. A quickly repeated attack will lead
    to a Denial of Service.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Squid users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=net-proxy/squid-2.6.12"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-1560');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200703-27.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200703-27] Squid: Denial of Service');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Squid: Denial of Service');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-proxy/squid", unaffected: make_list("ge 2.6.12"), vulnerable: make_list("lt 2.6.12")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
