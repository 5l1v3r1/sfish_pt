#
# (C) Tenable Network Security
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
 seealso  = '\n';


include("compat.inc");

if ( description )
{
 script_id(14280);
 script_version("$Revision: 1.9 $");
 script_cve_id("CVE-2004-0755");

 script_name(english:"FreeBSD : Ruby insecure file permissions in the CGI session management (170)");


 script_set_attribute(attribute:"synopsis", value:
"The remote device is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing an update to the system

The following package is affected: ruby" );
 script_set_attribute(attribute:"solution", value:
"Update the package on the remote host" );
 script_set_attribute(attribute:"risk_factor", value:"High" );
 script_end_attributes();

 script_summary(english:"Check for ruby");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2007 Tenable Network Security");
 family["english"] = "FreeBSD Local Security Checks";
 script_family(english:family["english"]);
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/FreeBSD/pkg_info");
 exit(0);
}

include('freebsd_package.inc');


pkg_test(pkg:"ruby<1.6.8.2004.07.26",
     url:"http://www.FreeBSD.org/ports/portaudit/e811aaf1-f015-11d8-876f-00902714cc7c.html",
     problem:'Ruby insecure file permissions in the CGI session management',
     seealso:seealso);

pkg_test(pkg:"ruby>=1.7.0<1.8.1.2004.07.23",
     url:"http://www.FreeBSD.org/ports/portaudit/e811aaf1-f015-11d8-876f-00902714cc7c.html",
     problem:'Ruby insecure file permissions in the CGI session management',
     seealso:seealso);
