# Autor: Francisco Palenzuela Luque @fpalenzuela
# Fecha: 24/10/2017


<#
.SYNOPSIS
  Comprueba si una ip esta en una lista dnsbl de momento solo comprueba ipv4.

.DESCRIPTION
  Comprueba si una ip esta en una lista dnsbl de momento solo comprueba ipv4.
  Como lo comprueba: Convertimos una ip dada a formato PTR y realiza una consulta 
  a cada servidor dentro del archivo SERVIDORESDNSBL.TXT

.EXAMPLE 
TEST-DNSBLIPv4 1.76.98.103

.LINK    
 Post del script: www.aprendizdesysadmin.com
#>

[CmdletBinding()]
     param ( 
       # El parametro es obligatorio y el pattern es para direcciones Ipv4.
       [Parameter(Mandatory=$true)] 
       [ValidatePattern("^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$")]           
        [string]$IP

     )



# Separamos la ip en Octetos, los metemos en un array y los
# ordenamos al reves, para posteriormente agregarles . entre cada octeto.
$IPalReves = ($IP -split '\.')[3..0] -join '.'

$Servidores = Get-Content -path .\servidoresDNSBL.txt

clear-host
Write-Host ('[] - REALIZANDO COMPROBACIONES PARA LA IP: {0}' -f $IP)



foreach ($servidor in $Servidores) {
  
    $chequea = $IPalReves + "." + $servidor
  
    try {
        [System.Net.Dns]::gethostAddresses("$chequea") | Out-Null
        Write-Host  -BackgroundColor DarkRed -ForegroundColor White ('[] Encontrado {0} en {1}' -f $chequea, $servidor)
    }
    catch {
        Write-Host  -BackgroundColor DarkGreen -ForegroundColor Black ('[] {0} no esta en {1}' -f $chequea, $servidor)
    }

}
