Function Connect-StaytusServer {
    <#
    .SYNOPSIS
    Establishes session connection details for Staytus Server
    
    .DESCRIPTION
    Establishes session connection details for Staytus Server
    
    .PARAMETER StaytusServer
    Hostname of Staytus server. If non-standard port use hostname:port format
    
    .PARAMETER UseSSL
    Toggle using HTTPS as protocol. If non-standard SSL port is in use, ensure hostname:port is used in StaytusServer parameter
    
    .PARAMETER Credential
    X-Auth-Token (username) and X-Auth-Secret (password) for Staytus api user
    
    .EXAMPLE
    Connect-StaytusServer -StaytusServer staytus.contoso.com:8787 -Credential (Get-Credential)

    .EXAMPLE
    Connect-StaytusServer -StaytusServer staytus.contoso.com -Credential $credential

    .EXAMPLE
    Connect-StaytusServer -StaytusServer staytus.contoso.com -Credential $credential -UseSSL
    
    .NOTES
    General notes
    #>
    [cmdletBinding(HelpUri="https://github.com/steviecoaster/Uh-Oh/blob/main/docs/Connect-StaytusServer.md")]
    Param(
        [Parameter(Mandatory)]
        [Alias('Hostname')]
        [String]
        $StaytusServer,

        [Parameter()]
        [Switch]
        $UseSSL,

        [Parameter(Mandatory)]
        [PSCredential]
        $Credential
    )

    process { 

        switch ($UseSSL) {
            $true { $protocol = 'https' }
            default { $protocol = 'http' }
        }

        $StaytusConnection = $Script:StaytusConnection = @{
            Hostname = "$($protocol)://$StaytusServer/api/v1"
            Header   = @{
                'X-Auth-Token'  = "$($Credential.Username)"
                'X-Auth-Secret' = "$($Credential.GetNetworkCredential().Password)"
            }
        }
    }
}