Function Connect-PoshBotStaytusServer {
    [PoshBot.BotCommand(CommandName = 'ConnectStaytus')]

    [cmdletBinding()]
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

    New-PoshBotCardResponse -Title 'Staytus Connection Info' -Text $StaytusConnection
}