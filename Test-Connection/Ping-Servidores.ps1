# Leemos el archivo 
$listado = get-content .\list_servidores.txt

#Para cada ip del archivo 
ForEach ($ip in $listado) {
    if (test-connection -ComputerName $ip -Count 1 -Quiet) { 
        # Si el test-connection es correcto
        write-host -BackgroundColor DarkGreen -ForegroundColor Black ('{0} - RESPONDE' -f $ip)
        } else {   
          # Si el test-connection no es correcto
          Write-Host -BackgroundColor DarkRed -ForegroundColor White ('{0} - NO RESPONDE' -f $ip)
        }
}

