Function New-PoshBotStaytusIncident {
    <#
    .SYNOPSIS
    Raises a new Staytus Incident card alert
    
    .DESCRIPTION
    Raises a new Staytus Incident card alert
    
    .PARAMETER Title
    Title of the Incident
    
    .PARAMETER Service
    The affected Service
    
    .PARAMETER Status
    The current status
    
    .PARAMETER State
    Current affected service State
    
    .PARAMETER NotifySubscribers
    Email Service subscribers
    
    .EXAMPLE
    $IncidentParams = @{
        Title  = 'Website response times degraded'
        Service = 'Storefront'
        Status = 'Investigating'
        State = 'degraded-performance'
    }

    New-PoshBotStaytusIncident @IncidentParams
    #>
    [PoshBot.BotCommand(CommandName = 'NewStaytusIncident')]
    [CmdletBinding(HelpUri="https://github.com/steviecoaster/Uh-Oh/blob/main/docs/New-PoshBotStaytusIncident.md")]
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
        $NotifySubscribers
    )

    begin {
        if(-not $StaytusConnection) {
            throw "Not connected to Staytus server. Did you run Connect-StaytusServer?"
        }
    }

    process {

        $incidentParams = @{
            Title = $Title
            Service = $Service
            Status = $Status
            State = $State
        }

        if($NotifySubscribers){
            $incidentParams.Add('NotifySubscribers',$true)
        }

        $incident = New-StaytusIncident @incidentParams

        $response = Get-StaytusIncident -Id $incident.data.id
        
        New-PoshBotCardResponse -Title 'New Staytus Incident!' -Text $response

    }

}