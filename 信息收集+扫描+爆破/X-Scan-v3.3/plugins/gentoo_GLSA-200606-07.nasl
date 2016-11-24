# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200606-07.xml
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
 script_id(21680);
 script_version("$Revision: 1.4 $");
 script_xref(name: "GLSA", value: "200606-07");
 script_cve_id("CVE-2006-2607");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200606-07 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200606-07
(Vixie Cron: Privilege Escalation)


    Roman Veretelnikov discovered that Vixie Cron fails to properly
    check whether it can drop privileges accordingly if setuid() in
    do_command.c fails due to a user exceeding assigned resource limits.
  
Impact

    Local users can execute code with root privileges by deliberately
    exceeding their assigned resource limits and then starting a command
    through Vixie Cron. This requires resource limits to be in place on the
    machine.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Vixie Cron users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=sys-process/vixie-cron-4.1-r9"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-2607');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200606-07.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200606-07] Vixie Cron: Privilege Escalation');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Vixie Cron: Privilege Escalation');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "sys-process/vixie-cron", unaffected: make_list("ge 4.1-r9"), vulnerable: make_list("lt 4.1-r9")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
