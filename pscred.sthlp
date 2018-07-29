{smcl}
{* *! version 1.2.1  8dec2016}{...}
{findalias asfradohelp}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help pscred"}{...}
{viewerjumpto "Syntax" "pscred##syntax"}{...}
{viewerjumpto "Description" "pscred##description"}{...}
{viewerjumpto "Options" "pscred##options"}{...}
{viewerjumpto "Remarks" "pscred##remarks"}{...}
{viewerjumpto "Examples" "pscred##examples"}{...}
{title:Title}

{phang}
{bf:pscred} {hline 2} Uses Windows Powershell to get credentials and store them in .txt files

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:pscred}
{it:ufile pfile}{cmd: [,}{it:options}]

{synoptset 25 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt s:aveto(output_folder)}}     output folder {p_end}
{synopt:{opt c:name(filename)}}      name of .ps1 file {p_end}
{synopt:{opt d:el}}     deletes .ps1 file on completion{p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:pscred} creates a script and runs the script using windows powershell. A pop-up 
window will appear asking for users credentials. The captured username is stored as {it:ufile.txt}
and the password is stored as {it:pfile.txt}, both in {it:output_folder}. The username is stored in 
plain text and the password is stored as a secure string. The .ps1 file {it:filename} is saved 
in {it:output_folder} also.

{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt saveto(output_folder)} specifies that the .ps1 and .txt files will be  saved in
				{it:output_folder}; default will save all files to current working directory

{phang}				
{opt cname(filename)} names the output .ps1 file {it:filename}; default file is saved as cred.ps1
			
{phang}
{opt del} specifies that the .ps1 file will be deleted once the powershell script has run.

{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:pscred} captures users credentials for use in other operations. It stores usernames in plain text
and passwords as secure strings. It is recommended that users do not regularly store these files on
their system but generate them temporarily for use in other programs and delete them once 
finished.

{pstd}
As this program makes use of windows powershell it can only be used on the windows operating system.
Users who have not used windows powershell before should note that by default it may not have sufficient
administrative privileges to perform the operations in {cmd:pscred}. First time users should run  
"Set-ExecutionPolicy RemoteSigned" when running windows powershell as administrator. This command specifies that scripts created on the 
current system and files with a digital signature may be run. This keeps powershell privileges quite strict
but is sufficient for this program as the .ps1 script executed is created locally.


{marker examples}{...}
{title:Examples}

{pstd}{bf:Example 1: Storing credentials in the current working directory}

{pstd}The following saves "username.txt", "password.txt" and "cred.ps1" in the working directory:{p_end}
{phang2}{cmd:. pscred username password}{p_end}

{pstd}{bf:Example 2: Storing credentials in a specific folder}

{pstd}The following saves "username.txt", "password.txt" and "cred.ps1" in C:\Users\Credentials:{p_end}
{phang2}{cmd:. pscred username password, s(C:\Users\Credentials)}{p_end}

{pstd}To delete the .ps1 file once the script has been run in powershell:{p_end}
{phang2}{cmd:. pscred username password, s(C:\Users\Credentials) d}{p_end} 

{marker author}{...}
{title:Author}

{pstd}Iain Snoddy{p_end}
{pstd}iainsnoddy@gmail.com{p_end}
