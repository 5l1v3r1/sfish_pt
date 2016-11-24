# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200704-05.xml
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
 script_id(24938);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200704-05");
 script_cve_id("CVE-2007-1614");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200704-05 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200704-05
(zziplib: Buffer Overflow)


    dmcox dmcox discovered a boundary error in the zzip_open_shared_io()
    function from zzip/file.c .
  
Impact

    A remote attacker could entice a user to run a zziplib function with an
    overly long string as an argument which would trigger the buffer
    overflow and may lead to the execution of arbitrary code.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All zziplib users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-libs/zziplib-0.13.49"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-1614');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200704-05.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200704-05] zziplib: Buffer Overflow');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'zziplib: Buffer Overflow');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-libs/zziplib", unaffected: make_list("ge 0.13.49"), vulnerable: make_list("lt 0.13.49")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
