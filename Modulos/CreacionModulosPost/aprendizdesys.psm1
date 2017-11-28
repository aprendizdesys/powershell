# Modulo del ejemplo del post : https://aprendizdesysadmin.com/powershell_-creacion-de-modulos/
# 

Function InfoSoftInstalado(){
 <#
 .SYNOPSIS
   Esta funcion mira en el registro las aplicaciones instaladas.

 .DESCRIPTION
  Esta funcion mira en el registro las aplicaciones instaladas. 
  No es necesario introducir el computername.
  
 .EXAMPLE 
  InfoSoftInstalado

 .EXAMPLE
  InfoSoftInstalado -ComputerName .

 .LINK    
  www.aprendizdesysadmin.com
  #>  

[CmdletBinding()]
    param(
        [string[]]$ComputerName
    )
    BEGIN {
        Write-host -ForegroundColor DarkGreen ('===================')
        Write-host -ForegroundColor DarkGreen ('[] Reading Registry') 
    }
    PROCESS{
         $RegistryPath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
         $SelObjects = @{'Property'='DisplayName','DisplayVersion','Publisher','InstallDate'}
         Get-ItemProperty  $RegistryPath | Select-Object @SelObjects | format-table -autosize
    }
   END{}
}

Function InfoDisco() {
 <#
 .SYNOPSIS
   Esta funcion obtiene informacion del disco y particiones
  
 .EXAMPLE 
  InfoDisco()
 #>
 BEGIN{
    Write-host -ForegroundColor DarkGreen ('=======================')
    Write-host -ForegroundColor DarkGreen ('[] Disk Data Gathering ') 
 }
 PROCESS{
    Get-Disk | format-list
    Get-partition
}
END{}
}

Export-ModuleMember -function InfoSoftInstalado,InfoDisco
