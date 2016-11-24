# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200505-04.xml
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
 script_id(18230);
 script_version("$Revision: 1.6 $");
 script_xref(name: "GLSA", value: "200505-04");
 script_cve_id("CVE-2005-1431");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200505-04 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200505-04
(GnuTLS: Denial of Service vulnerability)


    A vulnerability has been discovered in the record packet parsing
    in the GnuTLS library. Additionally, a flaw was also found in the RSA
    key export functionality.
  
Impact

    A remote attacker could exploit this vulnerability and cause a
    Denial of Service to any application that utilizes the GnuTLS library.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All GnuTLS users should remove the existing installation and
    upgrade to the latest version:
    # emerge --sync
    # emerge --unmerge gnutls
    # emerge --ask --oneshot --verbose net-libs/gnutls
    Due to small API changes with the previous version, please do
    the following to ensure your applications are using the latest GnuTLS
    that you just emerged.
    # revdep-rebuild --soname-regexp libgnutls.so.1[0-1]
    Previously exported RSA keys can be fixed by executing the
    following command on the key files:
    # certtool -k infile outfile
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://lists.gnupg.org/pipermail/gnutls-dev/2005-April/000858.html');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-1431');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200505-04.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200505-04] GnuTLS: Denial of Service vulnerability');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'GnuTLS: Denial of Service vulnerability');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-libs/gnutls", unaffected: make_list("ge 1.2.3", "rge 1.0.25"), vulnerable: make_list("lt 1.2.3")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
