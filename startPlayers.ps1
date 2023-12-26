Import-Module ./startPlayers.psm1 -Force

Write-Output "Writing full logs to $logFile"

$curlFiles = Get-CurlFiles

if(Test-Path $tempFolder){
    Remove-Item $tempFolder -Force -Recurse
}
Write-Log "Creating temp folder"
New-Item -Type Directory $tempFolder | Out-Null

foreach ($curlFile in $curlFiles) {
    Write-Output "Processing $curlFile"
    $dates = Get-DateArray
   
    $i = 0
    foreach($date in $dates) {
        $percent = [math]::Round(100 * $i/$dates.Length, 1)
        Write-Progress -Activity "Setting lineups" -Status "$percent% Complete:" -PercentComplete $percent
        Write-Log "Reading file: $curlFile"
        $curlFilePath = Join-Path -Path $inputsFolder -ChildPath $curlFile
        $ogFileContent = Get-Content $curlFilePath -Raw
        
        Set-ActivePlayersForDate $curlFile $ogFileContent $date
        $i = $i + 1
    }
}

Remove-Item $tempFolder
