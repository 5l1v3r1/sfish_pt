# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200705-06.xml
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
 script_id(25160);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200705-06");
 script_cve_id("CVE-2007-1667");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200705-06 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200705-06
(X.Org X11 library: Multiple integer overflows)


    Multiple integer overflows have been reported in the XGetPixel()
    function of the X.Org X11 library.
  
Impact

    By enticing a user to open a specially crafted image, an attacker could
    cause a Denial of Service or an integer overflow, potentially resulting
    in the execution of arbitrary code with root privileges.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All X.Org X11 library users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=x11-libs/libX11-1.0.3-r2"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-1667');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200705-06.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200705-06] X.Org X11 library: Multiple integer overflows');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'X.Org X11 library: Multiple integer overflows');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "x11-libs/libX11", unaffected: make_list("ge 1.0.3-r2"), vulnerable: make_list("lt 1.0.3-r2")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
