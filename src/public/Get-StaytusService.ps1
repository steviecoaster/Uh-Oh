Function Get-StaytusService {
    <#
    .SYNOPSIS
    Return Service information for services defined in Staytus
    
    .DESCRIPTION
    Return Service information for services defined in Staytus
    
    .PARAMETER Service
    The Service to interrogate
    
    .EXAMPLE
    Return all service details
    
    Get-StaytusService
    
    .EXAMPLE
    Return service details for given service(s)

    Get-StaytusService -Service Storefront

    .EXAMPLE
    
    Get-StaytusService -Service Storefront,Sql

    #>
    [CmdletBinding(HelpUri = "https://github.com/steviecoaster/Uh-Oh/blob/main/docs/Get-StaytusService.md")]
    Param(
        [Parameter()]
        [String[]]
        $Service
    )

    begin {
        if (-not $StaytusConnection) {
            throw "Not connected to Staytus server. Did you run Connect-StaytusServer?"
        }
    }

    process {

        if ($Service) {

            foreach($s in $Service) {
                
                $endpoint = 'services/info'

                $irmParams = @{
                    Header = $StaytusConnection.Header
                    Method = 'GET'
                }

                $Body = @{
                    service = $s
                }
                $irmParams.Add('Uri', "$($StaytusConnection.Hostname)/$($endpoint)")
                $irmParams.Add('ContentType', 'application/json')
                $irmParams.Add('Body', ($Body | ConvertTo-Json))

                (Invoke-RestMethod @irmParams).data
            }
        }
        else {
            $endpoint = 'services/all'

            $irmParams = @{
                Header = $StaytusConnection.Header
                Method = 'GET'
            }
            $irmParams.Add('Uri', "$($StaytusConnection.Hostname)/$($endpoint)")
            (Invoke-RestMethod @irmParams).data

        }

        
         
    }

}