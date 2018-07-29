# winmail
Send email within stata using windows powershell scripting. Ever wanted to send an email to yourself at the end of a file? Or email results from a long running maximum likelihood estimation to yourself while you go for a stroll? Well now you can! With winmail! Windows users only, sorry mac users!

There are two modules, one manages users credentials and the second creates and calls the powershell script. As a precaution I would usggest users use a unique email address for use with this program. Credentials are temporarily stored in a .txt file on the users system though the program cleans them up after use or in the case of an error.

## pscred
This stata module uses windows powershell to capture and store users credentials. The program will open a windows powershell terminal and a pop-up window will request users input their username and password. The username will be stored as a plain .txt file in a specified location while the password will be stored as a secure string.

It is recommended that users do not store their credentials on their local system. pscred is designed to store credentials only temporarily for use in other programs in the email suite. Typically these programs delete users credentials upon completion (successful or otherwise).

*Suggested use*: pscred was created only as a useful tool for other programs in the email suite

*Dependencies*: Windows Powershell be installed on the users system


## winmail
Stata module that uses windows powershell to send an email via SMTP (Simple Mail Transfer Protocol). Winmail creates a .ps1 script which is then run using windows powershell. Emails are sent via the Send-MailMessage cmdlet.  The program is flexible and uses pscred to capture users credentials, deleting them upon completion.

Users can send email from any email address that uses SMTP. Some mail providers will require access settings be modified (such as gmail). Emails can be formatted using html and attachments can be included.

*Suggested use*: Send an email on the completion of a program, attaching the .tex file outputted by the program being run.

*Dependencies*: pscred, tknz, and Windows Powershell be installed on the users system
