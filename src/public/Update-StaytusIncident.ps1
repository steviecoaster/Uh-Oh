Function Update-StaytusIncident {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [Argumentcompleter(
            {
            param($Command,$Parameter,$WordToComplete,$CommandAst,$FakeBoundParams)
            $results = @((Get-StaytusIncident).title)
            if($WordToComplete){
                 $results.Where{$_.Title -match "^$WordToComplete"}
            } else { $results}
            
        }
        )]
        [String]
        $Incident,

        [Parameter(Mandatory)]
        [String]
        $Update,

        [Parameter()]
        [ValidateSet('major-outage',
            'operational',
            'degraded-performance',
            'partial-outage',
            'maintenance')]
        [String]
        $Status,

        [Parameter()]
        [ValidateSet('Investigating', 'Identified', 'Monitoring', 'Resolved')]
        [String]
        $State,

        [Parameter()]
        [Switch]
        $NotifySubscribers
    )

    begin {
        if(-not $StaytusConnection) {
            throw "Not connected to Staytus server. Did you run Connect-StaytusServer?"
        }
        
        $endpoint = 'issues/update'
    }
    
   
    process {

        [int]$id = (Get-StaytusIncident -Title $Incident).id

        $Body = @{
            id = $id
            text = "$Update"
        }

        

        if($Status){
            $Body.Add("status","$($Status.ToLower())")
        }

        if($State){
            $Body.Add("state","$($State.tolower())")
        }

        if($NotifySubscribers){
            $Body.Add("notify",$true)
        }


        $irmParams = @{
            ContentType = 'application/json'
            Method = 'POST'
            Uri = "$($StaytusConnection.Hostname)/$($endpoint)"
            Header = $StaytusConnection.Header
            Body = ($Body | ConvertTo-Json)

        }

        Invoke-RestMethod @irmParams
    }
}