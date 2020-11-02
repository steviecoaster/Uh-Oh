$incidentCommands = Get-Command -Module Uh-Oh | Where-Object { $_.Name -match "Service" }


Describe "Validating Working Online Help" {
    Foreach ($command in $incidentCommands) {
        It "$($command.Name) Online Help resolves" {
            (Invoke-WebRequest $command.HelpUri).StatusCode | Should -Be 200
        }
    }
}

Describe "Command returns expected output" {
    
    BeforeAll {
        $StaytusServer = '192.168.2.239'
        $Global:StaytusConnection = @{
                Hostname = "$($protocol)://$StaytusServer/api/v1"
                Header   = @{
                    'X-Auth-Token'  = (New-Guid).Guid
                    'X-Auth-Secret' = (New-Guid).Guid
                }
            
        }
    }

    Mock -ModuleName Uh-Oh -CommandName Invoke-RestMethod -MockWith {
        return [pscustomobject]@{
               id = 4
               name = 'Things'
               permalink = 'customer-support'
               position = 4 
               description = $null
               created_at = (Get-Date).ToLongTimeString()
               updated_at = (Get-Date).ToLongTimeString()
               status = @{
                   id = 1
                   name = 'Operational'
                   permalink = 'Operational'
                   color = '2fcc66'
                   status_type = 'ok'
                   created_at = (Get-Date).ToLongTimeString()
                   updated_at = (Get-Date).ToLongTimeString()
               }
        }
    } -ParameterFilter { $Hostname -eq $StaytusServer}

    
    It "Should return a name" {
        $service = Get-StaytusService

        $service.Name | Should -Be 'Things'
    }
}