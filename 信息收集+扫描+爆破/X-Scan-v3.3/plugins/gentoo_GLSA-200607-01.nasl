# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200607-01.xml
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
 script_id(21908);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200607-01");
 script_cve_id("CVE-2006-3355");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200607-01 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200607-01
(mpg123: Heap overflow)


    In httpdget.c, a variable is assigned to the heap, and is supposed to
    receive a smaller allocation. As this variable was not terminated
    properly, strncpy() will overwrite the data assigned next in memory.
  
Impact

    By enticing a user to visit a malicious URL, an attacker could possibly
    execute arbitrary code with the rights of the user running mpg123.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All mpg123 users should update to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=media-sound/mpg123-0.59s-r11"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3355');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200607-01.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200607-01] mpg123: Heap overflow');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'mpg123: Heap overflow');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "media-sound/mpg123", unaffected: make_list("ge 0.59s-r11"), vulnerable: make_list("lt 0.59s-r11")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
