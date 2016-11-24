# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200503-30.xml
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
 script_id(17619);
 script_version("$Revision: 1.7 $");
 script_xref(name: "GLSA", value: "200503-30");
 script_cve_id("CVE-2004-1156", "CVE-2005-0230", "CVE-2005-0231", "CVE-2005-0232", "CVE-2005-0233", "CVE-2005-0255", "CVE-2005-0399", "CVE-2005-0401", "CVE-2005-0527", "CVE-2005-0578", "CVE-2005-0584", "CVE-2005-0585", "CVE-2005-0588", "CVE-2005-0590", "CVE-2005-0591", "CVE-2005-0592", "CVE-2005-0593");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200503-30 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200503-30
(Mozilla Suite: Multiple vulnerabilities)


    The following vulnerabilities were found and fixed in the Mozilla
    Suite:
    Mark Dowd from ISS X-Force reported an exploitable
    heap overrun in the GIF processing of obsolete Netscape extension 2
    (CAN-2005-0399)
    Michael Krax reported that plugins can be used
    to load privileged content and trick the user to interact with it
    (CAN-2005-0232, CAN-2005-0527)
    Michael Krax also reported
    potential spoofing or cross-site-scripting issues through overlapping
    windows, image or scrollbar drag-and-drop, and by dropping javascript:
    links on tabs (CAN-2005-0230, CAN-2005-0231, CAN-2005-0401,
    CAN-2005-0591)
    Daniel de Wildt and Gael Delalleau discovered a
    memory overwrite in a string library (CAN-2005-0255)
    Wind Li
    discovered a possible heap overflow in UTF8 to Unicode conversion
    (CAN-2005-0592)
    Eric Johanson reported that Internationalized
    Domain Name (IDN) features allow homograph attacks (CAN-2005-0233)
    Mook, Doug Turner, Kohei Yoshino and M. Deaudelin reported various
    ways of spoofing the SSL "secure site" indicator (CAN-2005-0593)
    Georgi Guninski discovered that XSLT can include stylesheets from
    arbitrary hosts (CAN-2005-0588)
    Secunia discovered a way of
    injecting content into a popup opened by another website
    (CAN-2004-1156)
    Phil Ringnalda reported a possible way to
    spoof Install source with user:pass@host (CAN-2005-0590)
    Jakob
    Balle from Secunia discovered a possible way of spoofing the Download
    dialog source (CAN-2005-0585)
    Christian Schmidt reported a
    potential spoofing issue in HTTP auth prompt tab (CAN-2005-0584)
    Finally, Tavis Ormandy of the Gentoo Linux Security Audit Team
    discovered that Mozilla insecurely creates temporary filenames in
    /tmp/plugtmp (CAN-2005-0578)
  
Impact

    The GIF heap overflow could be triggered by a malicious GIF
    image that would end up executing arbitrary code with the rights of the
    user running Mozilla. The other overflow issues, while not thought to
    be exploitable, would have the same impact
    By setting up
    malicious websites and convincing users to follow untrusted links or
    obey very specific drag-and-drop or download instructions, attackers
    may leverage the various spoofing issues to fake other websites to get
    access to confidential information, push users to download malicious
    files or make them interact with their browser preferences
    The
    temporary directory issue allows local attackers to overwrite arbitrary
    files with the rights of another local user
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All Mozilla Suite users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=www-client/mozilla-1.7.6"
    All Mozilla Suite binary users should upgrade to the latest
    version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=www-client/mozilla-bin-1.7.6"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2004-1156');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0230');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0231');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0232');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0233');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0255');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0399');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0401');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0527');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0578');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0584');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0585');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0588');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0590');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0591');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0592');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2005-0593');
script_set_attribute(attribute: 'see_also', value: 'http://www.mozilla.org/projects/security/known-vulnerabilities.html');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200503-30.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200503-30] Mozilla Suite: Multiple vulnerabilities');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Mozilla Suite: Multiple vulnerabilities');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "www-client/mozilla", unaffected: make_list("ge 1.7.6"), vulnerable: make_list("lt 1.7.6")
)) { security_hole(0); exit(0); }
if (qpkg_check(package: "www-client/mozilla-bin", unaffected: make_list("ge 1.7.6"), vulnerable: make_list("lt 1.7.6")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
