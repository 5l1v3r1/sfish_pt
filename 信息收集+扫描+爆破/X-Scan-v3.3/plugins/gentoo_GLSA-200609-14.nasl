# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200609-14.xml
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
 script_id(22458);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200609-14");
 script_cve_id("CVE-2006-3743", "CVE-2006-3744", "CVE-2006-4144");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200609-14 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200609-14
(ImageMagick: Multiple Vulnerabilities)


    Tavis Ormandy of the Google Security Team discovered a stack and heap
    buffer overflow in the GIMP XCF Image decoder and multiple heap and
    integer overflows in the SUN bitmap decoder. Damian Put discovered a
    heap overflow in the SGI image decoder.
  
Impact

    An attacker may be able to create a specially crafted image that, when
    processed with ImageMagick, executes arbitrary code with the privileges
    of the executing user.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All ImageMagick users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=media-gfx/imagemagick-6.2.9.5"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:H/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3743');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3744');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-4144');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200609-14.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200609-14] ImageMagick: Multiple Vulnerabilities');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'ImageMagick: Multiple Vulnerabilities');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "media-gfx/imagemagick", unaffected: make_list("ge 6.2.9.5"), vulnerable: make_list("lt 6.2.9.5")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
