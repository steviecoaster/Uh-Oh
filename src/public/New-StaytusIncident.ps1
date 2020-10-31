Function New-StaytusIncident {
    <#
    .SYNOPSIS
    Post a new incident to Staytus
    
    .DESCRIPTION
    Post a new service incident to your Staytus instance
    
    .PARAMETER StaytusServer
    Your staytus server. If using non-standard port, pass hostname:port
    
    .PARAMETER Title
    The incident Title
    
    .PARAMETER Service
    The affected Service
    
    .PARAMETER Status
    Current Status
    
    .PARAMETER State
    Current State
    
    .PARAMETER NotifySubscribers
    Send email to subscribers
    
    .PARAMETER UseSSL
    Use SSL in URI. If using non-standard HTTPS port, ensure 'hostname:port' format of StaytusServer is correct
    
    .PARAMETER Credential
    X-Auth-Token (username) and X-Auth-Secret (password) of Staytus API user
    
    .EXAMPLE
    New-StaytusIncident -Credential $credential -StaytusServer 192.168.2.239:8787 -Title 'PowerShell Test' -Service Junk 
-State Identified -Status major-outage

    .EXAMPLE
    $incidentParams = @{
        Credential = $credential
        StaytusServer = 192.168.2.239:8787
        Title = 'Well, that's not good. SQL is down!'
        Service = 'Sql Cluster'
        State = 'Identified'
        Status = 'major-outage'
    }

    New-StaytusIncident @incidentParams

    #>
    [CmdletBinding(HelpUri="https://github.com/steviecoaster/Uh-Oh/blob/main/docs/New-StaytusIncident.md")]
    Param(

        [Parameter(Mandatory)]
        [String]
        $Title,

        [Parameter(Mandatory)]
        [String[]]
        $Service,

        [Parameter(Mandatory)]
        [ValidateSet('major-outage',
            'operational',
            'degraded-performance',
            'partial-outage',
            'maintenance')]
        [String]
        $Status,

        [Parameter(Mandatory)]
        [ValidateSet('Investigating', 'Identified', 'Monitoring', 'Resolved')]
        [String]
        $State,

        [Parameter()]
        [Switch]
        $NotifySubscribers,

        [Parameter()]
        [Switch]
        $UseSSL
    )

    begin {
        if(-not $StaytusConnection) {
            throw "Not connected to Staytus server. Did you run Connect-StaytusServer?"
        }
    }
    
    process {
        $endpoint = 'issues/create'
        $irmParams = @{
            ContentType = 'application/json'
            Uri = "$($StaytusConnection.Hostname)/$($endpoint)"
            Header = $StaytusConnection.Header
            Method = 'POST'
        }

        $Body = @{
            title = $Title
            services = $Service
            status = $Status.ToLower()
            state = $State.ToLower()
        }

        if($NotifySubscribers){
            $Body.Add('Notify',$true)
        }

        $irmParams.Add('Body',($Body | ConvertTo-Json))

        Invoke-RestMethod @irmParams

    }
}