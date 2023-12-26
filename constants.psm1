$inputsFolder = "inputs"
$tempFolder = "tempScripts"
$tempScriptExtension = ".temp.ps1"
$endOfSeason = "2024-04-15"
$saveFile =  (Join-Path $env:TEMP "yahooFantasyStarted.json")

Export-ModuleMember -Function * -Alias * -Variable *