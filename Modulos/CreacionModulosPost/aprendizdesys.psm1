#==============================================================================
#  SCRIPT.........:  aprendizdesysModule.psm1
#  AUTHOR.........:  Francisco Palenzuela Luque
#  EMAIL..........:  fpalenzuela@gmail.com
#  TWITTER........:  @fpalenzuela
#  WEB............:  https://www.aprendizdesysadmin.com
#  VERSION........:  1.0
#  DATE...........:  27-11-2017
#  REQUIREMENTS...:  
#
#  DESCRIPTION....:  Modulo para el blog aprendizdesysadmin.com, conjunto de 
#                    funciones para poder utilizar en nuestros scripts o consola.
#
#  NOTES..........:  
# 
#  CUSTOMIZE......:  
#==============================================================================
#  REVISED BY.....:  
#  EMAIL..........:  
#  REVISION DATE..:  
#  REVISION NOTES.:
#
#==============================================================================


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
