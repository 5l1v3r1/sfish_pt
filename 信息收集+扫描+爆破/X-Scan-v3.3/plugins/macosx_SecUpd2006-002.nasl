#
# (C) Tenable Network Security, Inc.
#

if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(21073);
 script_version ("$Revision: 1.10 $");

 script_cve_id("CVE-2006-0400", "CVE-2006-0396", "CVE-2006-0397", "CVE-2006-0398", "CVE-2006-0399");
 script_bugtraq_id(17081);
 script_xref(name:"OSVDB", value:"23869");
 script_xref(name:"OSVDB", value:"23870");
 script_xref(name:"OSVDB", value:"23871");
 script_xref(name:"OSVDB", value:"23872");
 script_xref(name:"OSVDB", value:"23873");

 script_name(english:"Mac OS X Multiple Vulnerabilities (Security Update 2006-002)");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote operating system is missing a vendor supplied patch." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Apple Mac OS X, but lacks 
Security Update 2006-002. 

This security update contains fixes for the following
applications :

apache_mod_php
CoreTypes
LaunchServices
Mail
Safari
rsync" );
 script_set_attribute(attribute:"see_also", value:"http://docs.info.apple.com/article.html?artnum=303453" );
 script_set_attribute(attribute:"solution", value:
"Mac OS X 10.4 :
http://www.apple.com/support/downloads/securityupdate2006002macosx1045ppc.html
http://www.apple.com/support/downloads/securityupdate2006002macosx1045intel.html

Mac OS X 10.3 :
http://www.apple.com/support/downloads/securityupdate20060021039client.html
http://www.apple.com/support/downloads/securityupdate20060021039server.html" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:C/I:C/A:C" );

script_end_attributes();

 script_summary(english:"Check for Security Update 2006-002");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");
 script_family(english:"MacOS X Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/MacOSX/packages");
 exit(0);
}

#

packages = get_kb_item("Host/MacOSX/packages");
if ( ! packages ) exit(0);


uname = get_kb_item("Host/uname");
if ( egrep(pattern:"Darwin.* (7\.[0-9]\.|8\.[0-5]\.)", string:uname) )
{
  if (!egrep(pattern:"^SecUpd(Srvr)?(2006-00[23467]|2007-003)", string:packages)) security_hole(0);
}
