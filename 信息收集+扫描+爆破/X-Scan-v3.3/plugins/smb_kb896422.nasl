#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(18502);
 script_version("$Revision: 1.19 $");

 script_cve_id("CVE-2005-1206");
 script_bugtraq_id(13942);
 script_xref(name:"IAVA", value:"2005-t-0019");
 script_xref(name:"OSVDB", value:"17308");

 script_name(english:"MS05-027: Vulnerability in SMB Could Allow Remote Code Execution (896422) (uncredentialed check)");
 script_summary(english:"Determines the presence of update 896422 (remote check)");

 script_set_attribute(
  attribute:"synopsis",
  value:string(
   "Arbitrary code can be executed on the remote host due to a flaw in the\n",
   "SMB implementation."
  )
 );
 script_set_attribute(
  attribute:"description", 
  value:string(
   "The remote version of Windows contains a flaw in the Server Message\n",
   "Block (SMB) implementation that may allow an attacker to execute\n",
   "arbitrary code on the remote host. \n",
   "\n",
   "An attacker does not need to be authenticated to exploit this flaw."
  )
 );
 script_set_attribute(
  attribute:"solution", 
  value:string(
   "Microsoft has released a set of patches for Windows 2000, XP and\n",
   "2003 :\n",
   "\n",
   "http://www.microsoft.com/technet/security/bulletin/ms05-027.mspx"
  )
 );
 script_set_attribute(
  attribute:"cvss_vector", 
  value:"CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C"
 );
 script_end_attributes();

 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");
 script_family(english:"Windows");
 script_dependencies("smb_nativelanman.nasl");
 script_require_keys("Host/OS/smb");
 script_require_ports(139,445);
 exit(0);
}

#

include("smb_func.inc");

#---------------------------------------------------------#
# Function    : smb_trans_and_x                           #
# Description : TransAndX Request                         #
#---------------------------------------------------------#

global_var mpc, mdc;

function smb_trans_and_x2 (extra_parameters, transname, param, data, max_pcount)
{
 local_var header, parameters, dat, packet, ret, pad, trans, p_offset, d_offset, plen, dlen, elen, pad2;

 pad = pad2 = NULL;
 if (session_is_unicode () == 1)
   pad = raw_byte (b:0);
 else
   pad2 = raw_byte (b:0);

 header = smb_header (Command: SMB_COM_TRANSACTION,
                      Status: nt_status (Status: STATUS_SUCCESS));

 trans = cstring (string:transname);
 
 p_offset = 66 + strlen(trans) + strlen (extra_parameters);
 d_offset = p_offset + strlen (param);
 
 plen = strlen(param);
 dlen = strlen(data);
 elen = strlen(extra_parameters);

 parameters = raw_word (w:plen)            +   # total parameter count
	      raw_word (w:dlen) +   # total data count
	      raw_word (w:mpc)            +   # Max parameter count
	      raw_word (w:mdc)         +   # Max data count
	      raw_byte (b:0)            +   # Max setup count
              raw_byte (b:0)            +   # Reserved
	      raw_word (w:0)            +   # Flags
	      raw_dword (d:0)           +   # Timeout
	      raw_word (w:0)            +   # Reserved
	      raw_word (w:plen)            +   # Parameter count
	      raw_word (w:p_offset)           +   # Parameter offset
	      raw_word (w:dlen) +   # Data count
	      raw_word (w:d_offset)           +   # Data offset
	      raw_byte (b:elen/2)            +   # Setup count
	      raw_byte (b:0);               # Reserved

 parameters += extra_parameters; 
 
 parameters = smb_parameters (data:parameters);
 
 dat = pad +
       trans +
       pad2 +
       raw_word (w:0) +
       param +
       data;
 
 dat = smb_data (data:dat);

 packet = netbios_packet (header:header, parameters:parameters, data:dat);

 ret = smb_sendrecv (data:packet); 
 if (!ret)
   return NULL;
 
 return ret;
}


os = get_kb_item ("Host/OS/smb") ;
if ( ! os || "Windows" >!< os || "Windows 4.0" >< os ) exit(0);

port = int(get_kb_item("SMB/transport"));
if (!port) port = 445;

name = kb_smb_name();
if(!name)exit(0);

if(!get_port_state(port))exit(0);

soc = open_sock_tcp(port);
if(!soc)exit(0);

session_init (socket:soc,hostname:name);
ret = NetUseAdd (share:"IPC$");
if (ret != 1)
{
 close (soc);
 exit (0);
}

# smb_func.inc adjusts client buffer size to max_server_buffer_size + 0x100 if needed

mpc = session_get_server_max_size() / 2;
mdc = session_get_server_max_size() / 2 + 0x10;

fid = bind_pipe (pipe:"\browser", uuid:"6bffd098-a112-3610-9833-012892020162", vers:0);
if (isnull(fid))
{
 fid = bind_pipe (pipe:"\lsarpc", uuid:"12345778-1234-abcd-ef00-0123456789ab", vers:0);
 if (isnull (fid))
 {
   NetUseDel();
   exit (0);
 }
}

parameters = raw_word (w:TRANS_PIPE) +
             raw_word (w:fid);
opnum = 0;
ret = smb_trans_and_x2 (extra_parameters:parameters, transname:"\PIPE\", param:NULL, data:dce_rpc_request (code:opnum, data:NULL), max_pcount:0);

NetUseDel ();

if (strlen(ret) > 92)
  security_hole(port);
