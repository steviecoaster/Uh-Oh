Function Send-StaytusVerificationEmail {
    <#
    .SYNOPSIS
    Send a verification email to a Staytus subscriber
    
    .DESCRIPTION
    Send a verification email to a Staytus subscriber
    
    .PARAMETER EmailAddress
    The email address to send verification too
    
    .EXAMPLE
    Send-StaytusVerificationEmail
    #>
    [CmdletBinding(HelpUri="https://github.com/steviecoaster/Uh-Oh/blob/main/docs/Send-StaytusVerificationEmail.md")]
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

        $endpoint = 'subscribers/send_verification_email'

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