# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200910-01.xml
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
 script_id(42197);
 script_version("$Revision: 1.1 $");
 script_xref(name: "GLSA", value: "200910-01");
 script_cve_id("CVE-2009-3490");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200910-01 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200910-01
(Wget: Certificate validation error)


    The vendor reported that Wget does not properly handle Common Name (CN)
    fields in X.509 certificates that contain an ASCII NUL (\\0) character.
    Specifically, the processing of such fields is stopped at the first
    occurrence of a NUL character. This type of vulnerability was recently
    discovered by Dan Kaminsky and Moxie Marlinspike.
  
Impact

    A remote attacker might employ a specially crafted X.509 certificate,
    containing a NUL character in the Common Name field to conduct
    man-in-the-middle attacks on SSL connections made using Wget.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Wget users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose =net-misc/wget-1.12
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2009-3490');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200910-01.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200910-01] Wget: Certificate validation error');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Wget: Certificate validation error');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-misc/wget", unaffected: make_list("ge 1.12"), vulnerable: make_list("lt 1.12")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
