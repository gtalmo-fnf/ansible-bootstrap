# New-LocalUser ansible -Password (ConvertTo-SecureString -AsPlainText -Force '<PASSWD>'); 

# Add-LocalGroupMember -Group "Administrators" -Member ansible

Enable-WSManCredSSP -Role Server -Force

[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "C:\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file -EnableCredSSP -DisableBasicAuth -ForceNewSSLCert -CertValidityDays 3650

Remove-Item $file

winrm delete winrm/config/Listener?Address=*+Transport=HTTP

winrm enumerate winrm/config/Listener

