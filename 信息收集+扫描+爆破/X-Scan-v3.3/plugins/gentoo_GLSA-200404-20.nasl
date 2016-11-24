# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200404-20.xml
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
 script_id(14485);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200404-20");
 script_cve_id("CVE-2004-0372", "CVE-2004-1951");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200404-20 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200404-20
(Multiple vulnerabilities in xine)


    Several vulnerabilities were found in xine-ui and xine-lib. By opening
    a malicious MRL in any xine-lib based media player, an attacker can
    write arbitrary content to an arbitrary file, only restricted by the
    permissions of the user running the application. By opening a malicious
    playlist in the xine-ui media player, an attacker can write arbitrary
    content to an arbitrary file, only restricted by the permissions of the
    user running xine-ui. Finally, a temporary file is created in an
    insecure manner by the xine-check and xine-bugreport scripts,
    potentially allowing a local attacker to use a symlink attack.
  
Impact

    These three vulnerabilities may alow an attacker to corrupt system
    files, thus potentially leading to a Denial of Service. It is also
    theoretically possible, though very unlikely, to use these
    vulnerabilities to elevate the privileges of the attacker.
  
Workaround

    There is no known workaround at this time. All users are advised to
    upgrade to the latest available versions of xine-ui and xine-lib.
  
');
script_set_attribute(attribute:'solution', value: '
    All users of xine-ui or another xine-based player should upgrade to the
    latest stable versions:
    # emerge sync
    # emerge -pv ">=media-video/xine-ui-0.9.23-r2"
    # emerge ">=media-video/xine-ui-0.9.23-r2"
    # emerge -pv ">=media-libs/xine-lib-1_rc3-r3"
    # emerge ">=media-libs/xine-lib-1_rc3-r3"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:N');
script_set_attribute(attribute: 'see_also', value: 'http://xinehq.de/index.php/security');
script_set_attribute(attribute: 'see_also', value: 'http://nettwerked.mg2.org/advisories/xinebug');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2004-0372');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2004-1951');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200404-20.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200404-20] Multiple vulnerabilities in xine');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Multiple vulnerabilities in xine');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "media-libs/xine-lib", unaffected: make_list("ge 1_rc3-r3"), vulnerable: make_list("le 1_rc3-r2")
)) { security_warning(0); exit(0); }
if (qpkg_check(package: "media-video/xine-ui", unaffected: make_list("ge 0.9.23-r2"), vulnerable: make_list("le 0.9.23-r1")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
