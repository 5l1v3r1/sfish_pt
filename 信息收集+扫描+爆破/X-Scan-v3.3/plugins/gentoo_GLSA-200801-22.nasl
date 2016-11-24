# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200801-22.xml
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
 script_id(30139);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200801-22");
 script_cve_id("CVE-2007-6454");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200801-22 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200801-22
(PeerCast: Buffer overflow)


    Luigi Auriemma reported a heap-based buffer overflow within the
    "handshakeHTTP()" function when processing HTTP requests.
  
Impact

    A remote attacker could send a specially crafted request to the
    vulnerable server, possibly resulting in the remote execution of
    arbitrary code with the privileges of the user running the PeerCast
    server, usually "nobody".
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All PeerCast users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=media-sound/peercast-0.1218"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-6454');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200801-22.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200801-22] PeerCast: Buffer overflow');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'PeerCast: Buffer overflow');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "media-sound/peercast", unaffected: make_list("ge 0.1218"), vulnerable: make_list("lt 0.1218")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
