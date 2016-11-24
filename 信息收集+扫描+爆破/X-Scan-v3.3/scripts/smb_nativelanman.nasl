#
# This script was written by Renaud Deraison <deraison@cvs.nessus.org>
#
# Modified by Georges Dagousset <georges.dagousset@alert4web.com> : 
#   - extract OS and Domain
# Modified by KK Liu 08-25-2004 : 
#   - uses DFS flag in neg retun for Win2K Server detection
#  
# See the Nessus Scripts License for details
#

if(description)
{
 script_id(10785);
 script_version ("$Revision: 1.22 $");
 name["english"] = "SMB NativeLanMan";
 name["francais"] = "SMB NativeLanMan";
 
 script_name(english:name["english"],
 	     francais:name["francais"]);
 
 desc["english"] = "
This plugin attempts to determine what is the
remote native lan manager name (Samba, Windows...).

Risk factor : Low";

 script_description(english:desc["english"]);
 
 summary["english"] = "Extracts the remote native lan manager name";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2001 Renaud Deraison");
 family["english"] = "Windows";
 script_family(english:family["english"]);
 
 script_dependencies("netbios_name_get.nasl");
 script_require_keys("SMB/name");
 script_require_ports(139,445);
 exit(0);
}

include("smb_nt.inc");





#-------------------------------------------------------------#
# Negociate (pseudo-negociate actually) the protocol          #
# of the session                                              #
#-------------------------------------------------------------#
function my_smb_neg_prot(soc)
{
 neg_prot = raw_string
   	(
	
 0x00, 0x00, 0x00, 0xa4,    
 0xff, 0x53, 0x4d, 0x42, 0x72, 0x00, 0x00, 0x00,  
 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  
 0x00, 0x00, 0xc7, 0x13, 0x00, 0x00, 0x01, 0x00, 
  0x00, 0x81, 0x00, 0x02, 0x50, 0x43, 0x20, 0x4e,  
 0x45, 0x54, 0x57, 0x4f, 0x52, 0x4b, 0x20, 0x50, 
  0x52, 0x4f, 0x47, 0x52, 0x41, 0x4d, 0x20, 0x31,  
 0x2e, 0x30, 0x00, 0x02, 0x4d, 0x49, 0x43, 0x52,  
 0x4f, 0x53, 0x4f, 0x46, 0x54, 0x20, 0x4e, 0x45,  
 0x54, 0x57, 0x4f, 0x52, 0x4b, 0x53, 0x20, 0x31,  
 0x2e, 0x30, 0x33, 0x00, 0x02, 0x4d, 0x49, 0x43,  
 0x52, 0x4f, 0x53, 0x4f, 0x46, 0x54, 0x20, 0x4e,  
 0x45, 0x54, 0x57, 0x4f, 0x52, 0x4b, 0x53, 0x20,  
 0x33, 0x2e, 0x30, 0x00, 0x02, 0x4c, 0x41, 0x4e,  
 0x4d, 0x41, 0x4e, 0x31, 0x2e, 0x30, 0x00, 0x02,  
 0x4c, 0x4d, 0x31, 0x2e, 0x32, 0x58, 0x30, 0x30,  
 0x32, 0x00, 0x02, 0x53, 0x61, 0x6d, 0x62, 0x61,  
 0x00, 0x02, 0x4e, 0x54, 0x20, 0x4c, 0x41, 0x4e,  
 0x4d, 0x41, 0x4e, 0x20, 0x31, 0x2e, 0x30, 0x00,  
 0x02, 0x4e, 0x54, 0x20, 0x4c, 0x4d, 0x20, 0x30,  
 0x2e, 0x31, 0x32, 0x00		  
	
	 );
	 
 send(socket:soc, data:neg_prot);
 r = smb_recv(socket:soc, length:1024);
 if(strlen(r) < 10)return(FALSE);
 if(ord(r[9])==0)return(r);
 else return(FALSE);
}
 
#------------------------------------------------------#
# Set up a session                                     #
#------------------------------------------------------#
function my_smb_session_setup(soc)
{

  st = raw_string(0x00,0x00, 0x00, 0x51, 
	  0xFF, 0x53, 0x4D, 0x42, 0x73, 0x00, 0x00, 0x00,
	  0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
	  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	  0x00, 0xc7, 0x13, 0x00, 0x00, 0x00, 0x01, 0x00,
	  0x0d, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x02,
	  0x00, 0xc7, 0x13, 0xc3, 0x30, 0x00, 0x00, 0x00,
	  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	  0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x4D, 0x59,
	  0x47, 0x52, 0x4F, 0x55, 0x50, 0x00, 0x55, 0x6E,
	  0x69, 0x78, 0x00, 0x53, 0x61, 0x6d, 0x62, 0x61,
	  0x00);
	 
	 
  send(socket:soc, data:st);
  r = smb_recv(socket:soc, length:1024); 
  if(strlen(r) < 10)return(FALSE);
  if(ord(r[9])==0)return(r);
  else return(FALSE);
}	      			




#----------------------------------------------------------------#
# 			  main()                                 #
#----------------------------------------------------------------#		

w2ksrv = raw_string (0xFD,0xF3,0x00,0x00);
#w2k3   = raw_string (0xFD,0xF3,0x01,0x00);

name = kb_smb_name();
if(!name)name = "*SMBSERVER";

port = kb_smb_transport();

if(!get_port_state(port))exit(0);

soc = open_sock_tcp(port);
if(!soc)exit(0);
if ( port == 139 ) r = smb_session_request(soc:soc,  remote:name);
else r = "ok";


  
if(r)
 {
  r = smb_neg_prot(soc:soc);
    
  if(r)
  {
  stub = substr(r, 56, 59); 
 
  r = my_smb_session_setup(soc:soc);
  close(soc);
  if(strlen(r) < 37)exit(0);
  offset = 39 + ord(r[36]) * 2;
  if (offset >= strlen(r))exit(0);
  os = "";
  for (i=offset;ord(r[i]);i=i+1) {
   os = string(os, r[i]); # possible value:'Unix','Windows NT 4.0','Windows 5.0','Windows 5.1'...
  }
  offset = i + 1;
  if(offset >= strlen(r))exit(0); 
  version = "";
  for (i=offset;ord(r[i]);i=i+1) {
   version = string(version , r[i]); # possible value:'Samba x.y.z','Windows 2000 LAN Manager','NT LAN Manager 4.0'...
  }

  if (stub >< w2ksrv)
  {
  	os = 'Windows 5.0 Server';
  }
  
  offset = i + 1;
  if(offset >= strlen(r))exit(0);
  domain = "";
  for (i=offset;ord(r[i]);i=i+1) {
   domain = string(domain, r[i]);
  }
  report = string("The remote native lan manager is : ", version, "\nThe remote Operating System is : ", os, "\nThe remote SMB Domain Name is : ", domain, "\n");
  set_kb_item(name:"SMB/NativeLanManager", value:version);
  set_kb_item(name:"Host/OS/smb", value:os);
  security_note(port:port, data:report);
  }
}

 
