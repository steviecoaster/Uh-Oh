Function Get-StaytusSubscriber {
    <#
    .SYNOPSIS
    Get Staytus Subscriber information
    
    .DESCRIPTION
    Get Staytus Subscriber information
    
    .PARAMETER EmailAddress
    The email address to look-up
    
    .PARAMETER VerificationToken
    The verification token to look-up
    
    .EXAMPLE
    Get-StaytusSubscriber -EmailAddress joe@widgetstore.com

    .EXAMPLE
    Get-StaytusSubscriber -VerificationToken 70b89737-e8de-437d-8fd0-4f043789474b
    
    .NOTES
    General notes
    #>
    [cmdletBinding(HelpUri="https://github.com/steviecoaster/Uh-Oh/blob/main/docs/Get-StaytusSubscriber.md")]
    Param(
        [Parameter()]
        [String]
        $EmailAddress,

        [Parameter()]
        [String]
        $VerificationToken
    )

    begin {
        if(-not $StaytusConnection) {
            throw "Not connected to Staytus server. Did you run Connect-StaytusServer?"
        }
    }

    process {

        $endpoint = 'subscribers/info'

        $irmParams = @{
            Uri = "$($StaytusConnection.Hostname)/$($endpoint)"
            Header = $StaytusConnection.Header
            Method = 'GET'
        }
        if($PSBoundParameters){
            if($EmailAddress){
                $Body = @{
                    email_address = $EmailAddress
                }

                $irmParams.Add('ContentType','application/json')
                $irmParams.Add('Body',($Body | ConvertTo-Json))
            }

            if($VerificationToken){
                $Body = @{
                    verification_token = $VerificationToken
                }

                $irmParams.Add('ContentType','application/json')
                $irmParams.Add('Body',($Body | ConvertTo-Json))

            }

            (Invoke-RestMethod @irmParams).data
        } else {
            (Invoke-RestMethod @irmParams).data
        }
    }
}