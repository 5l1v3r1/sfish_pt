# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200606-13.xml
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
 script_id(21706);
 script_version("$Revision: 1.5 $");
 script_xref(name: "GLSA", value: "200606-13");
 script_cve_id("CVE-2006-2753");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200606-13 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200606-13
(MySQL: SQL Injection)


    MySQL is vulnerable to an injection flaw in mysql_real_escape() when
    used with multi-byte characters.
  
Impact

    Due to a flaw in the multi-byte character process, an attacker is still
    able to inject arbitary SQL statements into the MySQL server for
    execution.
  
Workaround

    There are a few workarounds available: NO_BACKSLASH_ESCAPES mode as a
    workaround for a bug in mysql_real_escape_string(): SET
    sql_mode=\'NO_BACKSLASH_ESCAPES\'; SET GLOBAL
    sql_mode=\'NO_BACKSLASH_ESCAPES\'; and server command line options:
    --sql-mode=NO_BACKSLASH_ESCAPES.
  
');
script_set_attribute(attribute:'solution', value: '
    All MySQL users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=dev-db/mysql-4.1.20"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-2753');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200606-13.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200606-13] MySQL: SQL Injection');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'MySQL: SQL Injection');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-db/mysql", unaffected: make_list("ge 5.0.22", "rge 4.1.20", "rge 4.1.21", "rge 4.1.22", "lt 4.1"), vulnerable: make_list("lt 5.0.22")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
