# Script para bloquear y desbloquear la escritura en dispostivos usb.
# Autor: Francisco Palenzuela Luque @fpalenzuela
# Blog: www.aprendizdesysadmin.com



# Constantes y variables
$RegRutaCompleta = 'hklm:\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies'
$RegRuta = 'hklm:\SYSTEM\CurrentControlSet\Control'
$ExisteRegistro = Test-Path -path $RegRutaCompleta
$UsbBloqueado = '0'  # 0=Desploqueado, 1=Bloqueado
$EstadoBloqueo = '0'


# FUNCIONES
Function CambioValor{
#Dependiendo de lo que le indiques activa o desactiva el bloqueo del usb.
write-host ('---------------------------------------------')
$Pregunta = Read-Host -Prompt '¿Que desea hacer, 0 desactiva bloqueo y 1 activa bloqueo'
    If (($Pregunta) -eq 0) {
        Set-ItemProperty -path $RegRutaCompleta -Name WriteProtect -Value "00000000"
        CompruebaValor
         } else {
        Set-ItemProperty -path $RegRutaCompleta -Name WriteProtect -Value "00000001"      
        CompruebaValor
    }
}

function CompruebaValor{
#Comprueba el valor de la entrada del registro.

    $EstadoBloqueo = Get-ItemProperty -path $RegRutaCompleta | Select-Object -Property WriteProtect
   If (($EstadoBloqueo.WriteProtect) -eq '1') {
       Write-Host -BackgroundColor DarkGreen -ForegroundColor Black ('- USB BLOQUEADO, NO SE PUEDE ESCRIBIR')
       } else {
       Write-Host -BackgroundColor DarkRed -ForegroundColor White ('- USB DESBLOQUEADO - AHORA SE PUEDE ESCRIBIR')
       }
}


Clear-Host
If (($ExisteRegistro) -eq $False) {
    Write-Host ('- No existe la ruta {0}' -f $RegRutaCompleta)
    Write-Host ('- Creando la ruta {0}' -f $RegRutaCompleta)
    New-Item -path $RegRuta -Name StorageDevicePolicies | Out-Null
    Write-Host ('- Creando entrada WriteProtect con valor {0}' -f $EstadoBloqueo)
    New-ItemProperty -path $RegRutaCompleta -Name WriteProtect -Value "00000000" -PropertyType DWORD | Out-Null
    } Else { 
    Write-Host ('- Ya existe la ruta {0}' -f $RegRutaCompleta)
    Write-Host ('- Comprobamos el valor')
    }

CompruebaValor
CambioValor
