Import-Module ./startPlayers.psm1 -Force

$curlFiles = Get-CurlFiles

if(Test-Path $tempFolder){
    Remove-Item $tempFolder -Force -Recurse
}
Write-Output "Creating temp folder"
New-Item -Type Directory $tempFolder

foreach ($curlFile in $curlFiles) {
    $dates = Get-DateArray
    foreach($date in $dates) {
        Write-HostWithTimestamp "Reading file: $curlFile"
        $curlFilePath = Join-Path -Path $inputsFolder -ChildPath $curlFile
        $ogFileContent = Get-Content $curlFilePath -Raw
        
        Set-ActivePlayersForDate $ogFileContent $date
        $sleepTime = 1 + (Get-Random -Maximum 8)
        Start-Sleep -Seconds $sleepTime
    }
}

Remove-Item $tempFolder