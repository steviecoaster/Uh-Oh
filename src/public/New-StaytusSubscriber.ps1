Function New-StaytusSubscriber{
    <#
    .SYNOPSIS
    Add a subscriber to Staytus
    
    .DESCRIPTION
    Add a subscriber to Staytus
    
    .PARAMETER EmailAddress
    The email address of the subscriber
    
    .PARAMETER Verified
    Automatically mark the email address as verified
    
    .EXAMPLE
    New-StaytusSubscriber -EmailAddress joe@widgetstore.com

    .EXAMPLE
    New-StaytusSubscriber -EmailAddress joe@widgetstore.com -Verified
    #>
    [CmdletBinding(HelpUri="https://github.com/steviecoaster/Uh-Oh/blob/main/docs/New-StaytusSubscriber.md")]
    Param(
        [Parameter()]
        [String]
        $EmailAddress,

        [Parameter()]
        [String]
        $Verified
    )

    begin {
        if(-not $StaytusConnection) {
            throw "Not connected to Staytus server. Did you run Connect-StaytusServer?"
        }
    }

    process {

        $endpoint = 'subscribers/add'

        $irmParams = @{
            Uri = "$($StaytusConnection.Hostname)/$($endpoint)"
            Header = $StaytusConnection.Header
            ContentType = 'application/json'
            Method = 'POST'
        }

        $Body = @{
            email_address = $EmailAddress
        }

        if($Verified){
            $Body.Add('verifictation',1)
        }

        $irmParams.Add('Body',($Body | ConvertTo-Json))

        (Invoke-RestMethod @irmParams).data

    }

}