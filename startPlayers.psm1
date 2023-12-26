Import-Module ./constants.psm1 -Force -Global


function Get-TempScriptFilename {
    param (
        [string]$ogFilename,
        [string]$dateString #yyyy-Mm-Dd
    )
    
    return $ogFilename + "." + $dateString + $tempScriptExtension
} 

function Set-ActivePlayersForDate {
    param (
        [string]$ogFilename,
        [string]$ogFileContent,
        [string]$dateString #yyyy-Mm-Dd
    )

    if (!(Test-Path $saveFile)){
        Write-Output '{}' >  $saveFile
    }
    $tempfilename = (Get-TempScriptFilename $ogFilename $dateString)

    $saved = Get-Content $saveFile | ConvertFrom-Json
    if($saved.$tempfilename){
        Write-HostWithTimestamp "Already processed"
        return
    }

    Write-HostWithTimestamp "Generating new script"
    $newContent = New-CurlContent $ogFileContent
    $newContent = Set-RequestDate -fileContent $newContent -dateString $dateString
    # Write generated script
    $tempPath = Join-Path -Path $tempFolder -ChildPath  $tempfilename
    Write-HostWithTimestamp "Writing new script to $tempPath"
    Write-Output $newContent > $tempPath 

    # Run generated script
    $sleepTime = 1 + (Get-Random -Maximum 8)
    Start-Sleep -Seconds $sleepTime
    Write-HostWithTimestamp "Running new script after delay: $sleepTime seconds"

    $res = & $tempPath 
    $parsedRes = $res | ConvertFrom-Json 
    $statusCode = $parsedRes.StatusCode
    if ($parsedRes.StatusCode -ne 200){
        Write-HostWithTimestamp "POST request had errors"
        "POST request had non-200 response"
        exit 1
    }
    $parsedContent = $parsedRes.Content | ConvertFrom-Json 
    if ($parsedContent.errors) {
        Write-HostWithTimestamp "POST request had errors"
        Write-HostWithTimestamp $parsedContent.errors
        exit 1
    }
    Write-HostWithTimestamp $parsedRes.StatusCode $parsedRes.StatusDescription

    $saved | Add-Member -MemberType NoteProperty -Name $tempfilename -Value 'true'
    $savedJson = $saved | ConvertTo-Json
    Write-Output $savedJson >  $saveFile

    Remove-Item $tempPath 
}


function New-CurlContent {
    param (
        [string]$fileContent
    )

    $fileContent = $fileContent.Replace("Invoke-WebRequest", '$response = Invoke-WebRequest')
    $fileContent += "`n" + '$res = @{}'
    $fileContent += "`n" + '$res.add("content",$response.Content)'
    $fileContent += "`n" + '$res.add("statusCode", $response.StatusCode)'
    $fileContent += "`n" + '$res.add("statusDescription", $response.StatusDescription)'
    $fileContent += "`n" + '$out = Out-String -InputObject $response'
    $fileContent += "`n" + '$res.add("fullResponse", $out)'
    $fileContent += "`n" + '$resJson = $res | ConvertTo-Json'
    $fileContent += "`n" + 'Write-Output $resJson'
    return $fileContent
}

function Set-RequestDate {
    param (
        [string]$fileContent,
        [string]$dateString #yyyy-Mm-Dd
    )

    $query = "&date=.*&crumb"
    $fileContent = $fileContent -replace $query, ("&date="  + $dateString + "&crumb")
    return $fileContent
}

function Get-CurlFiles {     
    $files = Get-ChildItem $inputsFolder
    $res = @()
    foreach ($file in $files){
        $filename =  $file.Name
        if ($filename.ToLower().Contains("readme")){
            continue
        }
        $res += $filename
    }
    return $res
}

function Write-HostWithTimestamp {
    $TimeStamp = Get-Date -Format "MM/dd/yy HH:mm:ss"
    Write-Host "$TimeStamp : "  @args
}

function Get-DateArray{
    $days = @() 
    $startDate = Get-Date
    $endDate = [DateTime] $endOfSeason 
    $date = [DateTime] $startDate
    while ($date -le $endDate) {
        $days += $date.ToString('yyyy-MM-dd')
        $date = $date.AddDays(1)
    }
    return $days
}