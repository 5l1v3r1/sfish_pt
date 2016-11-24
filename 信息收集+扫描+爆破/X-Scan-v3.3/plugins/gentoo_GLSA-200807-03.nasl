# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200807-03.xml
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
 script_id(33460);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200807-03");
 script_cve_id("CVE-2008-2371");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200807-03 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200807-03
(PCRE: Buffer overflow)


    Tavis Ormandy of the Google Security team reported a heap-based buffer
    overflow when compiling regular expression patterns containing
    "Internal Option Settings" such as "(?i)".
  
Impact

    A remote attacker could exploit this vulnerability by sending a
    specially crafted regular expression to an application making use of
    the PCRE library, which could possibly lead to the execution of
    arbitrary code or a Denial of Service.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All PCRE users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-libs/libpcre-7.7-r1"
    All GLib users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-libs/glib-2.16.3-r1"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-2371');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200807-03.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200807-03] PCRE: Buffer overflow');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'PCRE: Buffer overflow');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-libs/libpcre", unaffected: make_list("ge 7.7-r1"), vulnerable: make_list("lt 7.7-r1")
)) { security_hole(0); exit(0); }
if (qpkg_check(package: "dev-libs/glib", unaffected: make_list("ge 2.16.3-r1", "lt 2.14.0"), vulnerable: make_list("lt 2.16.3-r1")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
