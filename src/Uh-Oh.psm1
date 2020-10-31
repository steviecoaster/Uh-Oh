Function Connect-StaytusServer {
    <#
    .SYNOPSIS
    Establishes session connection details for Staytus Server
    
    .DESCRIPTION
    Establishes session connection details for Staytus Server
    
    .PARAMETER StaytusServer
    Hostname of Staytus server. If non-standard port use hostname:port format
    
    .PARAMETER UseSSL
    Toggle using HTTPS as protocol. If non-standard SSL port is in use, ensure hostname:port is used in StaytusServer parameter
    
    .PARAMETER Credential
    X-Auth-Token (username) and X-Auth-Secret (password) for Staytus api user
    
    .EXAMPLE
    Connect-StaytusServer -StaytusServer staytus.contoso.com:8787 -Credential (Get-Credential)

    .EXAMPLE
    Connect-StaytusServer -StaytusServer staytus.contoso.com -Credential $credential

    .EXAMPLE
    Connect-StaytusServer -StaytusServer staytus.contoso.com -Credential $credential -UseSSL
    
    .NOTES
    General notes
    #>
    [cmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [Alias('Hostname')]
        [String]
        $StaytusServer,

        [Parameter()]
        [Switch]
        $UseSSL,

        [Parameter(Mandatory)]
        [PSCredential]
        $Credential
    )

    process { 

        switch ($UseSSL) {
            $true { $protocol = 'https' }
            default { $protocol = 'http' }
        }

        $StaytusConnection = $Script:StaytusConnection = @{
            Hostname = "$($protocol)://$StaytusServer/api/v1"
            Header   = @{
                'X-Auth-Token'  = "$($Credential.Username)"
                'X-Auth-Secret' = "$($Credential.GetNetworkCredential().Password)"
            }
        }
    }
}
function Get-StaytusIncident {
    <#
    .SYNOPSIS
    Returns incident data for Staytus events
    
    .DESCRIPTION
    Returns detailed status information for incidents raised in your Staytus system
    
    .PARAMETER Title
    The Title of the incident to look for
    
    .PARAMETER Id
    The Id of the incident to look for
    
    .PARAMETER State
    The State of the incident to look for
    
    .PARAMETER Credential
    The X-Auth-Token (username) and X-Auth-Secret (password) for your Staytus API user
    
    .EXAMPLE
    Get-StaytusIncident -Credential (Get-Credential)

    .EXAMPLE
    Get-StaytusIncident -Credential $credential

    .EXAMPLE
    Get-StaytusIncident -Credential $credential -Id 1,36,4

    .EXAMPLE
    Get-STaytusIncident -Credential $credential -Title 'Website experiencing slow response','SQL Database degraded'

    .EXAMPLE
    Get-StaytusIncident -Credential $credential -State Identified,Investigating
        
    #>
    [CmdletBinding(DefaultParameterSetName='Credential')]
    Param(
        [Parameter(ParameterSetName='Title')]
        [String[]]
        $Title,

        [Parameter(ParameterSetName='Id')]
        [Int[]]
        $Id,

        [Parameter(ParameterSetName='State')]
        [ValidateSet('Investigating','Identified','Monitoring','Resolved')]
        [string[]]
        $State

    )

    begin {
        if(-not $StaytusConnection) {
            throw "Not connected to Staytus server. Did you run Connect-StaytusServer?"
        }
    }

    process {

        $endpoint = 'issues/all'

        $irmParams = @{
            Uri = "$($StaytusConnection.Hostname)/$($endpoint)"
            Header = $StaytusConnection.Header
            Method = 'GET'
        }


        $result = Invoke-RestMethod @irmParams

        switch($PSCmdlet.ParameterSetName) {
            'Title' {
                Foreach($t in $title){ 
                    $result.data | Where-Object { $_.Title -eq $t}
                }
            }
            'Id' {
                Foreach($i in $Id){ 
                    $result.data | Where-Object { $_.id -eq $i}
                }
            }
            'State' {
                Foreach($s in $State){ 
                    $result.data | Where-Object { $_.state -eq $s}
                }
            }
            default { $result.data}
        }
    }
}
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
    [CmdletBinding()]
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
