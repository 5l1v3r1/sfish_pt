#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(17254);
 script_version("$Revision: 1.8 $");

 script_cve_id("CVE-2005-0455", "CVE-2005-0611");
 script_bugtraq_id(12697, 12698);
 script_xref(name:"OSVDB", value:"14305");
 script_xref(name:"OSVDB", value:"14306");

 name["english"] = "RealPlayer Multiple Remote Overflows";

 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows application is affected by several remote
overflows." );
 script_set_attribute(attribute:"description", value:
"According to its build number, the installed version of RealPlayer /
RealOne Player / RealPlayer Enterprise for Windows might allow an
attacker to execute arbitrary code and delete arbitrary files on the
remote host. 

To exploit these flaws, an attacker would send a malformed SMIL or WAV
file to a user on the remote host and wait for him to open it." );
 script_set_attribute(attribute:"see_also", value:"http://www.idefense.com/application/poi/display?id=209&type=vulnerabilities" );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/391959" );
 script_set_attribute(attribute:"see_also", value:"http://service.real.com/help/faq/security/050224_player/EN/" );
 script_set_attribute(attribute:"solution", value:
"Upgrade according to the vendor advisories referenced above." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );
script_end_attributes();

 
 summary["english"] = "Checks RealPlayer build number";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 family["english"] = "Windows";
 script_family(english:family["english"]);
 
 script_dependencies("realplayer_detect.nasl");
 script_require_keys("SMB/RealPlayer/Product", "SMB/RealPlayer/Build");

 exit(0);
}


include("global_settings.inc");


# nb: RealPlayer Enterprise is also affected, but we don't currently
#     know which specific build number address the issues.
prod = get_kb_item("SMB/RealPlayer/Product");
if (
  prod &&
  (prod == "RealPlayer" || prod == "RealOne Player")
) {
  # Check build.
  build = get_kb_item("SMB/RealPlayer/Build");
  if (build)
  {
    # There's a problem if the build is:
    #  - [6.0.11.0, 6.0.11.872], RealOne Player.
    #  - [6.0.12.0, 6.0.12.1059), RealPlayer
    ver = split(build, sep:'.', keep:FALSE);
    if (
      int(ver[0]) < 6 ||
      (
        int(ver[0]) == 6 &&
        int(ver[1]) == 0 &&
        (
          int(ver[2]) < 11 ||
          (
            prod == "RealPlayer" &&
            int(ver[2]) == 11 && int(ver[3]) <= 872
          ) ||
          (
            prod == "RealOne Player" &&
            (
              int(ver[2]) == 11 ||
              (int(ver[2]) == 12 && int(ver[3]) < 1059)
            )
          )
        )
      )
    )
    {
      if (report_verbosity)
      {
        report = string(
          "\n",
          prod, " build ", build, " is installed on the remote host.\n"
        );
        security_hole(port:get_kb_item("SMB/transport"), extra:report);
      }
      else security_hole(get_kb_item("SMB/transport"));
    }
  }
}
