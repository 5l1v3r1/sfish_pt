#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if (description)
{
  script_id(40351);
  script_version("$Revision: 1.4 $");

  script_cve_id("CVE-2009-1194", "CVE-2009-2462", "CVE-2009-2463", "CVE-2009-2464", "CVE-2009-2465",
                "CVE-2009-2466", "CVE-2009-2467", "CVE-2009-2468", "CVE-2009-2469", "CVE-2009-2470",
                "CVE-2009-2471", "CVE-2009-2472");
  script_bugtraq_id(35765, 35766, 35767, 35769, 35770, 35772, 35773, 35774, 35775, 35776, 35925);
  script_xref(name:"OSVDB", value:"56218");
  script_xref(name:"OSVDB", value:"56219");
  script_xref(name:"OSVDB", value:"56220");
  script_xref(name:"OSVDB", value:"56221");
  script_xref(name:"OSVDB", value:"56222");
  script_xref(name:"OSVDB", value:"56223");
  script_xref(name:"OSVDB", value:"56224");
  script_xref(name:"OSVDB", value:"56225");
  script_xref(name:"OSVDB", value:"56226");
  script_xref(name:"OSVDB", value:"56227");
  script_xref(name:"OSVDB", value:"56228");
  script_xref(name:"OSVDB", value:"56229");
  script_xref(name:"OSVDB", value:"56230");
  script_xref(name:"OSVDB", value:"56231");
  script_xref(name:"OSVDB", value:"56232");
  script_xref(name:"OSVDB", value:"56385");
  script_xref(name:"OSVDB", value:"56716");
  script_xref(name:"Secunia", value:"35914");
  script_xref(name:"Secunia", value:"36001");

  script_name(english:"Firefox < 3.0.12 Multiple Vulnerabilities");
  script_summary(english:"Checks version of Firefox");

  script_set_attribute(attribute:"synopsis", value:
"The remote Windows host contains a web browser that is affected by
multiple vulnerabilities." );
  script_set_attribute(attribute:"description", value:
"The installed version of Firefox is earlier than 3.0.12. Such versions
are potentially affected by the following security issues :

  - Multiple memory corruption vulnerabilities could 
    potentially be exploited to execute arbitrary code. 
    (MFSA 2009-34)

  - It may be possible to crash the browser or potentially
    execute arbitrary code by using a flash object that
    presents a slow script dialog. (MFSA 2009-35) 

  - Glyph rendering libraries are affected by multiple heap/
    integer overflows. (MFSA 2009-36)

  - A vulnerability involving SVG element could be exploited
    to crash the browser or execute arbitrary code on the
    remote system. (MFSA 2009-37)

  - A SOCKS5 proxy that replies with a hostname containing
    more than 15 characters can corrupt the subsequent
    data stream.  This can lead to a denial of service,
    though there is reportedly no memory corruption.
    (MFSA 2009-38)

  - A vulnerability in 'setTimeout' could allow unsafe
    access to the 'this' object from chrome code. An
    attacker could exploit this flaw to run arbitrary 
    JavaScript with chrome privileges. (MFSA 2009-39)

  - It may be possible for JavaScript from one website
    to bypass cross origin wrapper, and unsafely access
    properties of an object from another website.
    (MFSA 2009-40)");

  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-34.html");
  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-35.html");
  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-36.html");
  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-37.html");
  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-38.html");
  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-39.html");
  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-40.html");
 
  script_set_attribute(attribute:"vuln_publication_date",   value:"2009/07/21");
  script_set_attribute(attribute:"patch_publication_date",  value:"2009/07/21");
  script_set_attribute(attribute:"plugin_publication_date", value:"2009/07/22");

  script_set_attribute(attribute:"solution", value:
"Upgrade to Firefox 3.0.12 or later." );
  script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );

  script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");
  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
  script_dependencies("mozilla_org_installed.nasl");
  script_require_keys("Mozilla/Firefox/Version");
  exit(0);
}

#

include("misc_func.inc");

ver = read_version_in_kb("Mozilla/Firefox/Version");
if (isnull(ver)) exit(0, "Mozilla Firefox not installed.");

if (
  ver[0] < 3 ||
  (ver[0] == 3 && ver[1] == 0 && ver[2] < 12)
) security_hole(get_kb_item("SMB/transport"));
