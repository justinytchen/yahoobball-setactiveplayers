param (
    [switch]$Reset = $false
)

Import-Module ./startPlayers.psm1 -Force

if($Reset){
    Write-Output "Found save file (previous attempt), will only update lineups of dates not previously set"
    Remove-Item $saveFile
}
elseif(Test-Path $saveFile){
    Write-Output "Found save file from a previous attempt at $saveFile, will only update lineups of dates not previously set"
    Write-Output "Use the Reset flag to update all lineups from today (./startPlayers.ps1 -Reset)"
}

Write-Log "-----------------------------------------------------"
Write-Log "Starting startPlayers.ps1...."
Write-Log "-----------------------------------------------------"
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
        Write-Progress -Activity "Setting lineups for $curlFile" -Status "$percent% Complete:" -PercentComplete $percent
        Write-Log "Reading file: $curlFile"
        $curlFilePath = Join-Path -Path $inputsFolder -ChildPath $curlFile
        $ogFileContent = Get-Content $curlFilePath -Raw
        
        Set-ActivePlayersForDate $curlFile $ogFileContent $date
        $i = $i + 1
    }
}

Remove-Item $tempFolder
