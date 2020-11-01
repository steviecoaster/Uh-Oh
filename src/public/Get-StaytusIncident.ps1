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
    
    .EXAMPLE
    Get-StaytusIncident

    .EXAMPLE
    Get-StaytusIncident -Id 1,36,4

    .EXAMPLE
    Get-STaytusIncident -Title 'Website experiencing slow response','SQL Database degraded'

    .EXAMPLE
    Get-StaytusIncident -State Identified,Investigating
        
    #>
    [CmdletBinding(DefaultParameterSetName='Credential',HelpUri="https://github.com/steviecoaster/Uh-Oh/blob/main/docs/Get-StaytusIncident.md")]
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