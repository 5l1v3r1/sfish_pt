# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200907-10.xml
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
 script_id(39781);
 script_version("$Revision: 1.2 $");
 script_xref(name: "GLSA", value: "200907-10");
 script_cve_id("CVE-2008-5110");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200907-10 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200907-10
(Syslog-ng: Chroot escape)


    Florian Grandel reported that Syslog-ng does not call chdir() before
    chroot() which leads to an inherited file descriptor to the current
    working directory.
  
Impact

    A local attacker might exploit a separate vulnerability in Syslog-ng
    and use this vulnerability to escape the chroot jail.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Syslog-ng 2.0 users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-admin/syslog-ng-2.0.10"
    All Syslog-ng 2.1 users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-admin/syslog-ng-2.1.3"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-5110');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200907-10.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200907-10] Syslog-ng: Chroot escape');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Syslog-ng: Chroot escape');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "app-admin/syslog-ng", unaffected: make_list("rge 2.0.10", "ge 2.1.3"), vulnerable: make_list("lt 2.1.3")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
