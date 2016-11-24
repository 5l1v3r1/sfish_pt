# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200503-17.xml
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
 script_id(17319);
 script_version("$Revision: 1.7 $");
 script_xref(name: "GLSA", value: "200503-17");
 script_cve_id("CVE-2005-0664");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200503-17 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200503-17
(libexif: Buffer overflow vulnerability)


    libexif contains a buffer overflow vulnerability in the EXIF tag
    validation code. When opening an image with a specially crafted EXIF
    tag, the lack of validation can cause applications linked to libexif to
    crash.
  
Impact

    A specially crafted EXIF file could crash applications making use
    of libexif, potentially allowing the execution of arbitrary code with
    the privileges of the user running the application.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All libexif users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=media-libs/libexif-0.5.12-r1"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:H/Au:N/C:N/I:N/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0664');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200503-17.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200503-17] libexif: Buffer overflow vulnerability');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'libexif: Buffer overflow vulnerability');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "media-libs/libexif", unaffected: make_list("ge 0.5.12-r1"), vulnerable: make_list("lt 0.5.12-r1")
)) { security_note(0); exit(0); }
exit(0, "Host is not affected");
