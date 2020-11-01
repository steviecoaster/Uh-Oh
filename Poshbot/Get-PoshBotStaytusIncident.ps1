function Get-PoshBotStaytusIncident {
    <#
    .SYNOPSIS
    Report Staytus Incident info in Slack/Teams/Discord
    
    .DESCRIPTION
    Report Staytus Incident info in Slack/Teams/Discord
    
    .PARAMETER Title
    Title(s) of Incidents to report
    
    .PARAMETER Id
    Id(s) of Incidents to report
    
    .PARAMETER State
    State(s) of Incidents to report
    
    .EXAMPLE
    Get-PoshBotStaytusIncident

    .EXAMPLE
    Get-PoshBotStaytusIncident -Title 'Storefront Web Slow Response'

    .EXAMPLE
    Get-PoshBotStaytusIncident -State 'Investigating'
    
    #>
    [PoshBot.BotCommand(CommandName = 'StaytusInfo')]
    [CmdletBinding()]
    Param(
        [Parameter(ParameterSetName = 'Title')]
        [String[]]
        $Title,

        [Parameter(ParameterSetName = 'Id')]
        [Int[]]
        $Id,

        [Parameter(ParameterSetName = 'State')]
        [ValidateSet('Investigating', 'Identified', 'Monitoring', 'Resolved')]
        [string[]]
        $State

    )

    begin {
        if(-not $StaytusConnection) {
            throw "Not connected to Staytus server. Did you run Connect-StaytusServer?"
        }
    }
    
    process {
        if ($PSBoundParameters) {
            if ($Title) {
        
                $incidents = Get-StaytusIncident -Title $Title

                Foreach ($incident in $incidents) {

                    New-PoshBotCardResponse -Title 'Current Staytus Incidents' -Text $incident

                }

            }

            if ($Id) {
        
                $incidents = Get-StaytusIncident -Id $Id

                Foreach ($incident in $incidents) {

                    New-PoshBotCardResponse -Title 'Current Staytus Incidents' -Text $incident

                }

            }

            if ($State) {
        
                $incidents = Get-StaytusIncident -State $State

                Foreach ($incident in $incidents) {

                    New-PoshBotCardResponse -Title 'Current Staytus Incidents' -Text $incident

                }

            }
        }
        else {
        
            $incidents = Get-StaytusIncident

            Foreach ($incident in $incidents) {

                New-PoshBotCardResponse -Title 'Current Staytus Incidents' -Text $incident

            }
        }
    }
}