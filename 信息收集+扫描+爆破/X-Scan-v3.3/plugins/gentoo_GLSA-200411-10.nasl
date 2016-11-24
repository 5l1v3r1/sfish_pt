# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200411-10.xml
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
 script_id(15644);
 script_version("$Revision: 1.7 $");
 script_xref(name: "GLSA", value: "200411-10");
 script_cve_id("CVE-2004-1106");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200411-10 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200411-10
(Gallery: Cross-site scripting vulnerability)


    Jim Paris has discovered a cross-site scripting vulnerability in
    Gallery.
  
Impact

    By sending a carefully crafted URL, an attacker can inject and execute
    script code in the victim\'s browser window, and potentially compromise
    the users gallery.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Gallery users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=www-apps/gallery-1.4.4_p4"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://gallery.menalto.com/modules.php?op=modload&name=News&file=article&sid=142&mode=thread&order=0&thold=0');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2004-1106');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200411-10.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200411-10] Gallery: Cross-site scripting vulnerability');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Gallery: Cross-site scripting vulnerability');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "www-apps/gallery", unaffected: make_list("ge 1.4.4_p4"), vulnerable: make_list("lt 1.4.4_p4")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
