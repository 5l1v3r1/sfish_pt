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
 script_id(36459);
 script_version("$Revision: 1.3 $");
 script_cve_id("CVE-2004-0752");

 script_name(english:"FreeBSD : openoffice -- document disclosure (2262)");

script_set_attribute(attribute:'synopsis', value: 'The remote host is missing a security update');
script_set_attribute(attribute:'description', value:'The following package needs to be updated: ar-openoffice');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:P/I:N/A:N');
script_set_attribute(attribute:'solution', value: 'Update the package on the remote host');
script_set_attribute(attribute: 'see_also', value: 'http://securitytracker.com/alerts/2004/Sep/1011205.html
http://www.openoffice.org/issues/show_bug.cgi?id=33357');
script_set_attribute(attribute:'see_also', value: 'http://www.FreeBSD.org/ports/portaudit/c62dc69f-05c8-11d9-b45d-000c41e2cdad.html');

 script_end_attributes();
 script_summary(english:"Check for ar-openoffice");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 family["english"] = "FreeBSD Local Security Checks";
 script_family(english:family["english"]);
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/FreeBSD/pkg_info");
 exit(0);
}
global_var cvss_score;
cvss_score=2;
include('freebsd_package.inc');


holes_nb += pkg_test(pkg:"openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"ar-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"ca-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"cs-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"de-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"dk-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"el-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"es-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"et-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"fi-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"fr-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"gr-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"hu-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"it-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"ja-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"ko-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"nl-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"pl-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"pt-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"pt_BR-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"ru-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"se-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"sk-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"sl-openoffice-SI<1.1.2_1");

holes_nb += pkg_test(pkg:"tr-openoffice<1.1.2_1");

holes_nb += pkg_test(pkg:"zh-openoffice-CN<1.1.2_1");

holes_nb += pkg_test(pkg:"zh-openoffice-TW<1.1.2_1");

if (holes_nb == 0) exit(0,"Host is not affected");
