{smcl}
{* *! version 1.2.1  8dec2016}{...}
{findalias asfradohelp}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help winmail"}{...}
{viewerjumpto "Syntax" "winmail##syntax"}{...}
{viewerjumpto "Description" "winmail##description"}{...}
{viewerjumpto "Options" "winmail##options"}{...}
{viewerjumpto "Remarks" "winmail##remarks"}{...}
{viewerjumpto "Examples" "winmail##examples"}{...}
{title:Title}

{phang}
{bf:winmail} {hline 2} Uses Windows Powershell to send email

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:winmail}
{it:recipient}{cmd: [,}{it:options}]

{synoptset 25 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt s(subject)}}email subject{p_end}
{synopt:{opt b(body)}}email body{p_end}
{synopt:{opt a:tt(attachment)}}email file attchment; full file location required{p_end}
{synopt:{opt html(email html)}}html to be used in email body{p_end}
{synopt:{opt p:ar(paragraphs)}}paragraph breaks in email body{p_end}
{synopt:{opt ps:loc(folder_name)}}folder location of powershell script; default current working directory{p_end}
{synopt:{opt cr:ed}}asks user to provide credentials for email{p_end}
{synopt:{opt smtpp:ort(smtp port)}}smtp port; default 587 {p_end}
{synopt:{opt smtps:server(smtp server)}}smtp server address; default smtp.gmail.com{p_end}
{synopt:{opt fr:om(name)}}name of sender; default is email username {p_end}
{synopt:{opt uf:ile(username file)}}location and name of .txt file containg users email address in plain text {p_end}
{synopt:{opt pf:ile(password file)}}location and name of .txt file containing users email password stored as a secure string{p_end}
{synopt:{opt cc(cc_recipient)}}email address of person cc'd on email{p_end}
{synopt:{opt bcc(bcc_recipient)}}email address of person bcc'd on email{p_end}
{synopt:{opt nossl}}turns off ssl; by default ssl encryption is used{p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:winmail} sends email using SMTP(Simple Mail Transfer Protocol). A .ps1 script is created and
run using windows powershell. Users must either specify the location of their email address and password or
specify {opt cred} in which case {bf:{help pscred:pscred}} is used to temporarily create username and
password files. By allowing for paragraphing and the inclusion of html, users are provided with substantial
flexibility in the format of their email.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt s(subject)} declares the email subject

{phang}				
{opt b(body)} specifies the body of the email to be sent. The body should be inputted as a single string with 
	blocks of text being parsed by "|". Each substring separated by "|" will be numbered and modified using
	html wrappers if specified. Text inputted as "line1 | line2 | line3" will be treated as 3 separate blocks
	of text and numbered "1,2,3".

{phang}				
{opt att(attachment)} gives the location and name of the file to be included as an attachment to the email
	
{phang}				
{opt html(email html)} provides the html to be included in the email. The html provided modifies the text provided
	in {it:body}. As each block of text parsed by "|" in {it:body} is numbered, html should be provided as wrappers
	around these numbers. Users should input a string where html wrappers are placed around numbers, with each number 
	representing a substring of {it:body}. For example "<i>1 <b>2</b></i> 3 4" makes all text in substrings
	1 and 2 italic and text in substring 2 bold. If {opt html} is specified it must include a number for
	every substring. If there are 4 inputted substrings and {opt html} takes input "<b> 1 </b> 2 3" then
	the fourth string will be missing from the email. Creating paragraphs can be done using {opt html} 
	or using {opt par}.

{phang}				
{opt par(paragraphs)} provides paragraph breaks between substrings parsed by "|" in {it:body}. The input to
	this option should take the format of a numbered list, for example par(1 3 5) creates a new paragraph 
	following substrings 1,3 and 5.

{phang}				
{opt psloc(folder_name)} gives the folder location of where the .ps1 file will be saved. By default this script
	will be called mailps.ps1.

{phang}				
{opt cred} if provided will call {cmd:pscred} and users will be asked for their email credentials. The 
	email address will be saved as a plain text file user.txt and the password will be saved as a secure string
	in pass.txt. Both files will be saved in {it:folder_name}. Upon sending the email these files will
	be automatically deleted.

{phang}				
{opt smtpport(smtp port)} gives the smtp port number. By default it is set to that used by gmail.

{phang}				
{opt smtpsserver(smtp server)} gives the smtp server address which by default is the gmail smtp server.

{phang}				
{opt from(name)} is the name of the sender which by default is not provided.

{phang}				
{opt ufile(username file)} gives the location and filename of the users email address saved as plain text in
	a .txt file. The file extension should not be included. This file is required if {opt cred} is not given. Unlike
	{opt cred} this file will not be deleted upon completion of the program.

{phang}				
{opt pfile(password file)} gives the location and filename of the users password saved as a secure string in
	a .txt file. The file extension should not be included. This file is required if {opt cred} is not given. Unlike
	{opt cred} this file will not be deleted upon completion of the program. To generate a secure string {cmd pscred} can 
	be used.

{phang}				
{opt cc(cc_recipient)} is the email address included as a cc to the email.

{phang}				
{opt  bcc(bcc_recipient)} is the email address included as a bcc to the email.

{phang}				
{opt  nossl} specifies that the Secure Sockets Layer (SSL) to establish a connection is not used. 

{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:winmail} sends an email from the users email account using smtp. Users provide their credentials, the 
recipients email address and features to be included in the email. By allowing for the inclusion of html
the emails created can be quite versatile. User credentials can either be inputted directly if stored on 
the users system or captured by the program. In the latter case, the files storing the credentials will
be deleted upon completion. At least one option of {opt b}, {opt s} or {opt att} must be given.

{pstd}
Emails are sent via windows powershell using the Send-MailMessage cmdlet (information here: 
https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.utility/send-mailmessage). 
A .ps1 script is created and stored on the users system in a specified location along with users credentials.

{pstd}
As this program makes use of windows powershell it can only be used on the windows operating system. 
Users who have not used windows powershell before should note that by default it may not have sufficient
administrative privileges to perform the operations in {cmd:winmail}. First time users should run  
"Set-ExecutionPolicy RemoteSigned" when running windows powershell as administrator and follow the
simple instructions on screen. This command specifies that scripts created on the current system 
and files with a digital signature may be run. This keeps powershell privileges quite strict but 
is sufficient for this program as the .ps1 script executed is created locally.

{pstd}
By default the smtp settings are set for the use of gmail accounts. These settings can be modified to
work for other email account types. For instance, to send an email usng outlook.com the stmpserver should
be set to "smtp-mail.outlook.com" and the stmpport to "587". Different email accounts may require users
to modify settings prior to the use of smtp. For instance, gmail requires that users allow access to 
less secure apps before an email can be sent using smtp via powershell. The speed of email delivery
may also differ across services. Outlook.com delivers mail much slower than gmail.com in testing.

{pstd}
{cmd:winmail} requires {bf:{help tknz:tknz}} and {bf:{help pscred:pscred}} be installed.


{marker examples}{...}
{title:Examples}

{pstd}{bf:Example 1: Sending a simple email}

{pstd}The following sends a simple email using gmail and a pop_up window will collect users 
gmail account details. {p_end}
{phang2}{cmd:. winmail friend@email.com, b(hello friend) cred}{p_end}

{pstd}If instead credentials are stored elsewhere {p_end}
{phang2}{cmd:. winmail friend@email.com, b(hello friend) uf(C:User\username) pf(C:User\password)}{p_end}

{pstd}To send using an outlook.com email account: {p_end}
{phang2}{cmd:. winmail friend@email.com, b(hello friend) cred smtp(587) smtps(smtp-mail.outlook.com)}{p_end}

{pstd}Including an attachment and subject:{p_end}
{phang2}{cmd:. winmail friend@email.com, s(greetings) b(hello friend) att(C:\User\file.txt) cred}{p_end}

{pstd}Including an address as cc:{p_end}
{phang2}{cmd:. winmail friend@email.com, b(hello friend) cc(otherfriend@email.com) cred}{p_end}


{pstd}{bf:Example 2: Sending an email with paragraphs}

{pstd}The following creates a new paragraph following the first and second substrings:{p_end}
{phang2}{cmd:. local body "hello friend, | How are you doing? | Best, Friend"}{p_end}
{phang2}{cmd:. winmail friend@email.com, b(`body') par(1 2) cred}{p_end}
{pstd}This will create an email which looks like:{p_end}

{phang2}{bf:hello friend,}{p_end}

{phang2}{bf:How are you doing?}{p_end}

{phang2}{bf:Best, Friend}{p_end}


{pstd}{bf:Example 3: Sending an email with html}

{pstd}The following bolds the second substring included in {it:body}: {p_end}
{phang2}{cmd:. local body "hello friend, | long time | no see!"}{p_end}
{phang2}{cmd:. winmail friend@email.com, b(`body') html(1 <b>2</b> 3) cred}{p_end}
{pstd}This will create an email which looks like:{p_end}

{phang2}hello friend, {bf: long time} no see! {p_end}

{pstd}Note that if we erroneously specified html(1 <b>2</b>) the output would be:   {p_end}

{phang2}hello friend, {bf: long time} {p_end}

{pstd}It is possible to include much more complicated html wrappers and expressions than used here.{p_end}


{pstd}{bf:Example 4: Using html to paragraph}

{pstd} Rather than using {opt par} to create paragraphs this can be done using {opt html}. The following uses of
the {cmd: winmail} command are equivalent: {p_end}

{phang2}{cmd:. local body "hello friend, | long time | no see!"}{p_end}
{phang2}{cmd:. winmail friend@email.com, b(`body') html(1 2<br><br> 3) cred}{p_end}
{phang2}{cmd:. winmail friend@email.com, b(`body') par(2) cred}{p_end}

{marker author}{...}
{title:Author}

{pstd}Iain Snoddy{p_end}
{pstd}iainsnoddy@gmail.com{p_end}

{marker Aknowledgements}{...}
{title:Aknowledgements}

{pstd}This program was inspired by {bf:{help psemail:psemail}} and a debt of gratitude is owed to its authors
Xuan Zhang, Dongliang Cui and Chuntao Li. Like their program, this program uses powershell to send email
from inside stata but uses a different cmdlet, allows for html input and a more secure way to input credentials.{p_end}
