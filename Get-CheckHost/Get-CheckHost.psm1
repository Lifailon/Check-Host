#!/bin/pwsh
function Get-CheckNode {
param (
    $headers
)
$Nodes_List  = Invoke-RestMethod -Headers $headers -Uri "https://check-host.net/nodes/hosts"
$Nodes_Name  = ($Nodes_List.nodes | Get-Member).Name[4..100]
$Collections = New-Object System.Collections.Generic.List[System.Object]
foreach ($n in $Nodes_Name) {
    $Collections.Add([PSCustomObject]@{
        Server   = $n;
        Address  = $Nodes_List.nodes."$n".ip
        Location = $Nodes_List.nodes."$n".location[2]
    })
}
$Collections
}
function Get-CheckHost {
<#
.SYNOPSIS
Module for check ping, hhtp, dns, tcp and udp to Internet via REST API Check Host
.DESCRIPTION
Example:
Get-CheckHost -List
Get-CheckHost -Server google.com -Type ping -Count 5
Get-CheckHost -Server gooooooooogle.com -Type ping -Count 5
Get-CheckHost -Server google.com:443 -Type http -Count 5
Get-CheckHost -Server google.com:444 -Type http -Count 5
Get-CheckHost -Server google.com -Type dns -Count 5
Get-CheckHost -Server google.com:443 -Type tcp -Count 5
Get-CheckHost -Server google.com:22 -Type tcp -Count 5
Get-CheckHost -Server google.com:22 -Type udp -Count 5
.LINK
https://check-host.net/about/api
https://github.com/Lifailon/Check-Host
#>
param (
    [string]$Server,
    [switch]$List,
    [ValidateSet("ping","dns","http","tcp","udp")][string]$Type = "ping",
    [ValidateRange(1,40)][int]$Count = 5,
    [string]$Node
)
$headers = @{
    "Accept" = "application/json"
}
if ($List) {
    Get-CheckNode -headers $headers
} else {
    $Nodes_List  = Get-CheckNode -headers $headers
    $url        = "https://check-host.net/check-$Type"+"?host=https://$Server&max_nodes=$Count"
    $request    = Invoke-RestMethod -Headers $Headers -Uri $url
    $request_id = $request.request_id
    $Nodes      = $($request.nodes | Get-Member).Name[4..100]
    $url_result = "https://check-host.net/check-result/$request_id"
    while ($true) {
        $check = Invoke-RestMethod -Headers $headers -Uri $url_result
        foreach ($n in $Nodes) {
            $result = $check.$n
            if ($result) {
                $test += 1
                continue
            } else {
                $test = 0
                break
            }
        }
        if ($test -eq $Nodes.Count) {
            break
        }
    }
    $irm         = Invoke-RestMethod -Headers $headers -Uri $url_result
    $Collections = New-Object System.Collections.Generic.List[System.Object]
    if ($Type -eq "ping") {
        foreach ($n in $Nodes) {
            $result_host = $irm.$n
            foreach ($i in 0..3) {
                $Collections.Add([PSCustomObject]@{
                    Server   = $n;
                    Location = $($Nodes_List | Where-Object Server -eq $n).Location;
                    Status   = $result_host.SyncRoot[0][$i][0];
                    Time     = $result_host.SyncRoot[0][$i][1]
                })
            }
        }
    }
    elseif ($Type -eq "http") {
        foreach ($n in $Nodes) {
            $result_host = $irm.$n
            switch($result_host[0][0]) {
                "1" {$Status = 'True'}
                "0" {$Status = 'False'}
            }
            $Collections.Add([PSCustomObject]@{
                Server   = $n;
                Location = $($Nodes_List | Where-Object Server -eq $n).Location;
                Status   = $Status;
                Time     = $result_host[0][1]
            })
        }
    }
    elseif ($Type -eq "dns") {
        foreach ($n in $Nodes) {
            $result_host = $irm.$n
            $Collections.Add([PSCustomObject]@{
                Server   = $n;
                Location = $($Nodes_List | Where-Object Server -eq $n).Location;
                A_Record = $result_host.A;
                TTL      = $result_host.TTL
            })
        }
    }
    elseif ($Type -eq "tcp") {
        foreach ($n in $Nodes) {
            $result_host = $irm.$n
            if ($result_host.error) {
                $Collections.Add([PSCustomObject]@{
                    Server   = $n;
                    Location = $($Nodes_List | Where-Object Server -eq $n).Location;
                    Status   = $result_host.error
                })
            }
            else {
                $Collections.Add([PSCustomObject]@{
                    Server   = $n;
                    Location = $($Nodes_List | Where-Object Server -eq $n).Location;
                    Status   = $result_host.time
                })
            }
        }
    }
    elseif ($Type -eq "udp") {
        foreach ($n in $Nodes) {
            $result_host = $irm.$n
            $Collections.Add([PSCustomObject]@{
                Server   = $n;
                Location = $($Nodes_List | Where-Object Server -eq $n).Location;
                Timeout   = $result_host.timeout
            })
        }
    }
$Collections
}
}
