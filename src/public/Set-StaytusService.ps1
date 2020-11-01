Function Set-StaytusService {
    <#
    .SYNOPSIS
    Set the status of a Staytus service
    
    .DESCRIPTION
    Set the status of a Staytus service
    
    .PARAMETER Service
    The service to adjust
    
    .PARAMETER Status
    The status to set the service too
    
    .EXAMPLE
    Set-StaytusService -Service 'Storefront' -Status operational

    #>
    [cmdletBinding(HelpUri = "https://github.com/steviecoaster/Uh-Oh/blob/main/docs/Get-StaytusService.md")]
    Param(
        [Parameter(Mandatory)]
        [ArgumentCompleter(
            {
                param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

                $results = (Get-StaytusService).permalink
                if ($WordToComplete) {
                    $results.Where{ $_ -match "^$WordToComplete" }
                }
                else { $results }
            }
            
        )]
        [String]
        $Service,

        [Parameter(Mandatory)]
        [ValidateSet('major-outage',
            'operational',
            'degraded-performance',
            'partial-outage',
            'maintenance')]
        [String]
        $Status
    )

    begin {
        if (-not $StaytusConnection) {
            throw "Not connected to Staytus server. Did you run Connect-StaytusServer?"
        }
    }

    process {

        $endpoint = 'services/set_status'
        $irmParams = @{
            ContentType = 'application/json'
            Uri         = "$($StaytusConnection.Hostname)/$($endpoint)"
            Header      = $StaytusConnection.Header
            Method      = 'POST'
            Body        = (@{
                    service = $Service.ToLower()
                    status  = $Status.ToLower()
                } | ConvertTo-Json)
        }

        Invoke-RestMethod @irmParams

    }
    
}