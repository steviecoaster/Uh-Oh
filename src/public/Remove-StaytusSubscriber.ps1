Function Remove-StaytusSubscriber {
    <#
    .SYNOPSIS
    Remove a Staytus subscriber
    
    .DESCRIPTION
    Remove a Staytus subscriber by email address
    
    .PARAMETER EmailAddress
    Email address of subscriber
    
    .EXAMPLE
    REmove-StaytusSubscriber -EmailAddress joe@widgetstore.com
    #>
    [CmdletBinding(HelpUri="https://github.com/steviecoaster/Uh-Oh/blob/main/docs/Remove-StaytusSubscriber.md",ConfirmImpact="High",SupportsShouldProcess)]
    Param(
        [Parameter(Mandatory)]
        [String]
        $EmailAddress
    )

    begin {
        if(-not $StaytusConnection) {
            throw "Not connected to Staytus server. Did you run Connect-StaytusServer?"
        }
    }

    process {

        $endpoint = 'subscribers/delete'

        $irmParams = @{
            Uri = "$($StaytusConnection.Hostname)/$($endpoint)"
            Header = $StaytusConnection.Header
            ContentType = 'application/json'
            Method = 'DELETE'
        }

        $Body = @{
            email_address = $EmailAddress
        }

        $irmParams.Add('Body',($Body | ConvertTo-Json))

        if($PSCmdlet.ShouldProcess($EmailAddress,"Remove Staytus subscriber")){
            
            Invoke-RestMethod @irmParams

        }

    }

}