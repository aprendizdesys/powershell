# Autor: Francisco Palenzuela Luque @fpalenzuela
# Fecha: 02/01/2017


<#
.SYNOPSIS
  Convierte una url acortada en su url real.

.EXAMPLE 
\Get-LongUrl.ps1  http://alturl.com/3gpn9

.LINK    
 Post del script: https://aprendizdesysadmin.com/powershell_-mini-tip-obteniendo-la-url-completa-de-un-enlace-corto/
#>

[CmdletBinding()]
     param ( 
       # El parametro es obligatorio y el pattern es para direcciones Ipv4.
       [Parameter(Mandatory=$true)] 
       [string]$ShortUrl

     )


$LongUrl = (Invoke-WebRequest -Uri $ShortUrl).BaseResponse.ResponseUri.OriginalString
Write-host ('La url larga es: {0}' -f $LongUrl)
