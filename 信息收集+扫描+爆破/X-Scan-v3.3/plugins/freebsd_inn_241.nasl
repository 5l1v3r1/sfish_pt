#
# (C) Tenable Network Security, Inc.
#
# This script contains information extracted from VuXML :
#
# Copyright 2003-2006 Jacques Vidrine and contributors
#
# Redistribution and use in source (VuXML) and 'compiled' forms (SGML,
# HTML, PDF, PostScript, RTF and so forth) with or without modification,
# are permitted provided that the following conditions are met:
# 1. Redistributions of source code (VuXML) must retain the above
#   copyright notice, this list of conditions and the following
#   disclaimer as the first lines of this file unmodified.
# 2. Redistributions in compiled form (transformed to other DTDs,
#   published online in any format, converted to PDF, PostScript,
#   RTF and other formats) must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer
#   in the documentation and/or other materials provided with the
#   distribution.
#
# THIS DOCUMENTATION IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
# OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
# OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS DOCUMENTATION,
# EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#
#

include('compat.inc');

if ( description )
{
 script_id(12554);
 script_version("$Revision: 1.6 $");

 script_name(english:"FreeBSD : Buffer overflow in INN control message handling (78)");

script_set_attribute(attribute:'synopsis', value: 'The remote host is missing a security update');
script_set_attribute(attribute:'description', value:'The following package needs to be updated: inn-stable');
script_set_attribute(attribute: 'risk_factor', value: 'High');
script_set_attribute(attribute:'solution', value: 'Update the package on the remote host');
script_set_attribute(attribute: 'see_also', value: 'http://bugs.splitbrain.org/index.php?do=details&amp;id=906
http://scary.beasts.org/security/CESA-2004-001.txt
http://secunia.com/advisories/21819/
http://trac.lighttpd.net/trac/ticket/1216
http://trac.lighttpd.net/trac/ticket/1232
http://www.mozilla.org/projects/security/known-vulnerabilities.html#seamonkey1.0.3
http://www.mozilla.org/security/announce/2006/mfsa2006-09.html
http://www.mozilla.org/security/announce/2006/mfsa2006-10.html
http://www.mozilla.org/security/announce/2006/mfsa2006-11.html
http://www.mozilla.org/security/announce/2006/mfsa2006-12.html
http://www.mozilla.org/security/announce/2006/mfsa2006-13.html
http://www.mozilla.org/security/announce/2006/mfsa2006-44.html
http://www.mozilla.org/security/announce/2008/mfsa2008-47.html
http://www.mozilla.org/security/announce/2008/mfsa2008-48.html
http://www.osvdb.org/8312
http://www.osvdb.org/8313
http://www.osvdb.org/8314
http://www.osvdb.org/8315
http://www.osvdb.org/8316');
script_set_attribute(attribute:'see_also', value: 'http://www.FreeBSD.org/ports/portaudit/fd376b8b-41e1-11d8-b096-0020ed76ef5a.html');

 script_end_attributes();
 script_summary(english:"Check for inn-stable");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 family["english"] = "FreeBSD Local Security Checks";
 script_family(english:family["english"]);
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/FreeBSD/pkg_info");
 exit(0);
}
global_var cvss_score;
cvss_score=10;
include('freebsd_package.inc');


pkg_test(pkg:"inn>=2.4.*<2.4.1");

pkg_test(pkg:"inn-stable<20031022_1");
