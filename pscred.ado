*! version 1.0 	 6 December 2016	Author: Iain Snoddy, iainsnoddy@gmail.com

/*
This program uses Windows Powershell to create .txt files storing
the individuals username and password. The password is stored in secure 
string format while the username is saved in plain text.
*/
	 
program define pscred
	version 12
	syntax namelist(min=2 max=2),	[folderc(string)  ///
									  cname(string) del ]	
									  
	tokenize `namelist'
	
	* This renames the .ps1 file	
	capture confirm e `cname'
	if _rc!=0 local cname cred 		
	
	*.ps1 location
	capture confirm e `folderc'
	if _rc!=0 local folderc `c(pwd)' 
	
	qui file open creds using "`folderc'\\`cname'.ps1", text write replace
	
	file write creds "$" "MyCred = Get-Credential"
	file write creds _n	"$" "MyCred.Password | ConvertFrom-SecureString | Out-File "  "`folderc'\\`2'.txt"
	file write creds _n	"$" "MyCred.UserName | Out-File -filepath "  "`folderc'\\`1'.txt" " -Encoding ASCII"
	file close creds
	
	shell powershell.exe "`folderc'\\`cname'.ps1"
	
	if "`del'"!="" 	winexec powershell.exe Remove-Item "`folderc'\\`cname'.ps1"
	
end
