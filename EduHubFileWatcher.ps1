try {
    Get-EventSubscriber -SourceIdentifier "WatchStaffDelta" -ErrorAction Stop | Unregister-Event -ErrorAction Stop
} catch {
    $_.Exception.Message | Write-Debug
}

$path = 'D:\eduHub'
$filter = '<eduhub csv file you want to monitor here eg. SF_8125_D.csv>'
$watcher = New-Object IO.FileSystemWatcher $path, $filter
$watcher.EnableRaisingEvents = $true

$action = {
    $webhookUrl = '<Google Chat WebHook URL'
    $SF_Keys = (Import-Csv "$path\$filter").SFKEY | Sort
    $timestamp = Get-Date -Format 'yyyy-MM-dd hh:mm:ss'
    $bodyText = "*$timestamp*
Staff Delta (SF_8125_D.csv) has been modified.
$SF_Keys"
    $body = @{
        text = $bodyText
    }
    Invoke-RestMethod -Uri $webhookUrl -Method Post -Body ($body | ConvertTo-Json) -ContentType 'application/json'
}

Register-ObjectEvent $watcher Changed -Action $action -SourceIdentifier "WatchStaffDelta"
