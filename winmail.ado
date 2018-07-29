*! version 1.0 	 11 December 2016	Author: Iain Snoddy, iainsnoddy@gmail.com


program define winmail
	version 12 
	syntax anything(name=to),  [s(string) b(string) Att(string) ///
							 html(string) Par(numlist) PSloc(string) CRed ///
							 SMTPport(string) SMTPServer(string) FRom(string) /// 
							 UFile(string) PFile(string) cc(string) bcc(string) ///
							 nossl ]
							
	
	if "`psloc'"=="" local psloc `c(pwd)'
	
	if "`cred'"!="" & "`ufile'"!="" {
		di as error `"Options cred and ufile() cannot be specified jointly"'
		exit
	}
	if  "`cred'"!="" & "`pfile'"!=""{
		di as error `"Options cred and pfile() cannot be specified jointly"'
		exit
	}
	if "`cred'"=="" & "`ufile'"=="" | "`cred'"=="" & "`pfile'"=="" {
		di as error "If option cred is not specified then the location of credentials must be provided in ufile() and pfile()"
		exit
	}
	if "`b'"=="" & "`html'"!=""{
		di as error "html() cannot be spcified when the email body is empty"
		exit
	}
	if "`b'"=="" & "`par'"!=""{
		di as error "par() cannot be spcified when the email body is empty"
		exit
	}	
	if "`b'"=="" & "`s'"=="" & "`att'"==""{
		di as error "At least one option of att(), b() or s() must be specified"
		exit
	}
	
	if "`cred'"!=""{
		pscred user pass, folderc("`psloc'") del 
		file open usert using `psloc'\user.txt, read
		file read usert username
		file close usert 
		winexec powershell.exe Remove-Item "`psloc'\user.txt"
	}
	else {
		file open usert using `ufile'.txt, read
		file read usert username
		file close usert 
	}
	
	if "`smtpport'"=="" local smtpport "587"
	if "`smtpserver'"=="" local smtpserver "smtp.gmail.com"
	if "`from'"=="" local from "`username'"
   
	tknz "`b'", p("|") nochar s(body)
	
	if "`html'"=="" & "`b'"!=""{
		numlist "1(1)`s(items)'"
		local html "`r(numlist)'"
	}
	  
	forvalues i=1/`s(items)'{
		local newpar: list posof "`i'" in par
		if `newpar'!=0 local html=subinstr("`html'","`i'","body`i'<br><br>",1)
		else local html=subinstr("`html'","`i'","body`i'",1)		
	}
	local html=subinstr("`html'","body",`"$""body"',.)

    * Create the .ps1 file to mail
	file open mailps using `psloc'\mailps.ps1, text write replace

	file write mailps _n "$" `"smtpPort="`smtpport'""'	
	file write mailps _n "$" `"smtpServer="`smtpserver'""'
	file write mailps _n "$" `"user="`username'""'
	if "`from'"=="" file write mailps _n "$" `"from="`username'""'
	else file write mailps _n "$" `"from="`from' <`username'>""'	
	if "`cred'"!="" file write mailps _n "$" "pass=Get-Content " "`psloc'\pass.txt" " | ConvertTo-SecureString"
	else file write mailps _n "$" "pass=Get-Content " "`pfile'.txt" " | ConvertTo-SecureString"
	file write mailps _n "$" `"to ="`to'""' 
	
	if "`b'"!=""{
		forvalues i=1/`s(items)'{ 
			file write mailps _n "$" `"body`i' = "' `"""' "`body`i''" `"""' 
		}
	}
	
	file write mailps _n "$" "Body = " `"""' "`html'" `"""'
	file write mailps _n  "$" "subject =" `"""' "`s'" `"""'
	file write mailps _n "$" "cred= New-Object System.Management.Automation.PSCredential(" "$" "user, " "$" "pass)"
	file write mailps _n "$" `"bcc="`bcc'""'		
	file write mailps _n "$" `"cc="`cc'""'		
	file write mailps _n  "$" `"file = "`att'""'
	  
	local smmto "-To " "$" "to"
	local smmfrom "-from " "$" "from"
	local smmsmtps "-SmtpServer " "$" "smtpServer"
	local smmsmtpp "-Port " "$" "smtpPort"	
	local smmcred "-Credential " "$" "cred"
	
	if "`nossl'"!="" local smmssl ""
	else local smmssl "-UseSsl "
	if "`s'"=="" local smmsub ""
	else local smmsub "-Subject " "$" "subject"	
	if "`bcc'"=="" local smmbcc ""
	else local smmbcc "-Bcc " "$" "`bcc'"
	if "`cc'"=="" local smmbcc ""
	else local smmcc "-Cc " "$" "`cc'"	 
	if "`att'"=="" local smmatt ""
	else local smmatt "-Attachments " "$" "`file'"			
	if "`html'"=="" local smmbody ""
	else local smmbody "-Body " "$" "Body -BodyAsHtml" 
	 	 
	file write mailps _n "Send-MailMessage `smmto' `smmfrom' `smmsub' `smmsmtps' "
	file write mailps "`smmsmtpp' `smmcred' `smmssl'" "`smmbcc'" "`smmcc'" "`smmatt'" "`smmbody'" 
	
	file close mailps

	* Run .ps1 script
	winexec powershell.exe `psloc'\mailps.ps1

	* Delete Password file 
	if "`cred'"!=""{
		sleep 3000
		winexec powershell.exe Remove-Item "`psloc'\pass.txt"
	}

end 
