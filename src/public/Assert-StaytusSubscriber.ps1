Function Assert-StaytusSubscriber {
    <#
    .SYNOPSIS
    Set a staytus subscriber as verified
    
    .DESCRIPTION
    Set a Staytus subscriber as verified
    
    .PARAMETER EmailAddress
    The email address to mark as verified
    
    .EXAMPLE
    Assert-StaytusSubscriber -EmailAddress joe@widgetstore.com
    #>
    [CmdletBinding(HelpUri="https://github.com/steviecoaster/Uh-Oh/blob/main/docs/Assert-StaytusSubscriber.md")]
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
        
        $endpoint = 'subscribers/verify'

        $irmParams = @{
            Uri = "$($StaytusConnection.Hostname)/$($endpoint)"
            Header = $StaytusConnection.Header
            ContentType = 'application/json'
            Method = 'POST'
        }

        $Body = @{
            email_address = $EmailAddress
        }

        $irmParams.Add('Body',($Body | ConvertTo-Json))

        Invoke-RestMethod @irmParams

    }
}