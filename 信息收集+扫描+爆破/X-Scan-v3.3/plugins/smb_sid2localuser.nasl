#
# (C) Tenable Network Security, Inc.
#

# @PREFERENCES@


include("compat.inc");

if(description)
{
 script_id(10860);
 script_version ("$Revision: 1.38 $");
 script_cve_id("CVE-2000-1200");
 script_bugtraq_id(959);
 script_xref(name:"OSVDB", value:"714");
 
 script_name(english:"SMB use host SID to enumerate local users");
 
 script_set_attribute(attribute:"synopsis", value:
"It is possible to enumerate local users." );
 script_set_attribute(attribute:"description", value:
"Using the host SID, it is possible to enumerate local users on the
remote Windows system." );
 script_set_attribute(attribute:"risk_factor", value:"None" );
 script_set_attribute(attribute:"solution", value:"n/a" );

script_end_attributes();

 script_summary(english:"Enumerates local users");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 script_family(english:"Windows");
 script_dependencies("netbios_name_get.nasl", "smb_login.nasl", "smb_host2sid.nasl");
 script_require_keys("SMB/transport", "SMB/name", "SMB/login", "SMB/password", "SMB/host_sid");
 script_require_ports(139, 445);
 script_add_preference(name:"Start UID : ", type:"entry", value:"1000");
 script_add_preference(name:"End UID : ", type:"entry", value:"1200");
 
 exit(0);
}


include("smb_func.inc");


#---------------------------------------------------------#
# call LsaLookupSid with only one sid			  #
#---------------------------------------------------------#

function get_name (handle, sid, rid)
{
 local_var fsid, psid, name, type, user, names, tmp;

 if ( isnull(sid[1]) )
	return NULL;

 fsid = sid[0] + raw_byte (b: ord(sid[1])+1) + substr(sid,2,strlen(sid)-1) + raw_dword (d:rid);

 psid = NULL;
 psid[0] = fsid;

 names = LsaLookupSid (handle:handle, sid_array:psid);
 if (isnull(names))
   return NULL;

 name = names[0];
 tmp = parse_lsalookupsid (data:name);
 type = tmp[0];
 user = tmp[2];

 return user;
}


port = kb_smb_transport();
if(!port)port = 139;
if(!get_port_state(port))exit(0);
__start_uid = script_get_preference("Start UID : ");
__end_uid   = script_get_preference("End UID : ");

if(__end_uid < __start_uid)
{
 t  = __end_uid;
 __end_uid = __start_uid;
 __start_uid = t;
}

if(!__start_uid)__start_uid = 1000;
if(!__end_uid)__end_uid = __start_uid + 200;

__no_enum = string(get_kb_item("SMB/LocalUsers/0"));
if(__no_enum)exit(0);

__no_enum = string(get_kb_item("SMB/LocalUsers/1"));
if(__no_enum)exit(0);


# we need the  netbios name of the host
name = kb_smb_name();
if(!name)exit(0);

login = kb_smb_login();
pass  = kb_smb_password();
if(!login)login = "";
if(!pass)pass = "";

domain = kb_smb_domain(); 


# we need the SID of the domain
sid = get_kb_item("SMB/host_sid");
if(!sid)exit(0);

sid = hex2raw2 (s:sid);

soc = open_sock_tcp(port);
if(!soc)exit(0);

session_init (socket:soc,hostname:name);
ret = NetUseAdd (login:login, password:pass, domain:domain, share:"IPC$");
if (ret != 1)
{
 close (soc);
 exit (0);
}

handle = LsaOpenPolicy (desired_access:0x20801);
if (isnull(handle))
{
  NetUseDel ();
  exit (0);
}

num_users = 0;
report = "";
set_kb_item(name:"SMB/LocalUsers/enumerated", value:TRUE);

n = get_name(handle:handle, sid:sid, rid:500);
if(n)
 {
 num_users = num_users + 1;
 report = report + string("  - ", n, " (id 500, Administrator account)\n");
 set_kb_item(name:string("SMB/LocalUsers/", num_users), value:n);
 set_kb_item(name:"SMB/LocalAdminName", value:n);
 }


n = get_name(handle:handle, sid:sid, rid:501);
if(n)
 {
  report = report + string("  - ", n, " (id 501, Guest account)\n");
  num_users = num_users + 1;
  set_kb_item(name:string("SMB/LocalUsers/", num_users), value:n);
 }

#
# Retrieve the name of the users between __start_uid and __start_uid
#
mycounter = __start_uid;
while(1)
{
 n = get_name(handle:handle, sid:sid, rid:mycounter);
 if(n && mycounter != 500 && mycounter != 501)
 {
  report = report + string("  - ", n, " (id ", mycounter, ")\n");
  num_users = num_users + 1;
  set_kb_item(name:string("SMB/LocalUsers/", num_users), value:n);
 }
 
 mycounter++;
 if(mycounter > __end_uid)break;
}


LsaClose (handle:handle);
NetUseDel ();
	
if(num_users > 0)
{
 report = string(
  "\n",
  report,
  "\n",
  "Note that, in addition to the Administrator and Guest accounts, Nessus\n",
  "has enumerated only those local users with IDs between ", __start_uid, " and ", __end_uid, ".\n",
  "To use a different range, edit the scan policy and change the 'Start\n",
  "UID' and/or 'End UID' preferences for this plugin, then re-run the\n",
  "scan.\n"
 );
 security_note(extra:report, port:port);
}
