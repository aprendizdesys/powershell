# Get-PublicIP.ps1
# Nos Devuelve la IP Publica de nuestra red.
# Post: https://aprendizdesysadmin.com/powershell_-sustituyendo-a-curl-y-wget-con-ps/

Clear-Host
$IP = Invoke-WebRequest -Uri http://ifconfig.me/ip
Write-Host -BackgroundColor DarkGreen -ForegroundColor Black ('Mi IP publica es : {0}' -f $IP)
