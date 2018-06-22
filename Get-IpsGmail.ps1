# Autor: Francisco Palenzuela Luque @fpalenzuela
# Fecha: 22/06/2018
# Blog: www.aprendizdesysadmin.com

<#
.SYNOPSIS
  Busca lista de dominios de google y extrae las ips.

.EXAMPLE 
\Get-IpsGmail.ps1

.LINK    
 Post del script: https://aprendizdesysadmin.com/powershell_-mini-tip-obteniendo-la-url-completa-de-un-enlace-corto/
#>

#Constantes y variables
$opciones =[System.StringSplitOptions]::RemoveEmptyEntries
$separadores="v=spf1","ip4:"," ","~all","include:","ip6:"



$listadominiostemp = (Resolve-DnsName -type TXT _spf.google.com -Server 8.8.8.8).strings
$listadominios = $listadominiostemp.split($separadores,$opciones)



foreach ($dominio in $listadominios) {
    $ListadoStringsTemp = (Resolve-DnsName -type TXT $dominio -Server 8.8.8.8).strings
    $ListadoStrings = $ListadoStrings + $ListadoStringsTemp
   
}

$ListadoStrings.split($separadores,$opciones)
    



