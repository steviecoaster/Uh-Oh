$incidentCommands = Get-Command | Where-Object { $_.Name -match "StaytusService" }


Describe "Validating Working Online Help" {
    Foreach ($command in $incidentCommands) {
        It "$($command.Name) Online Help resolves" {
            (Invoke-WebRequest $command.HelpUri).StatusCode | Should -Be 200
        }
    }
}

function Get-StaytusService{
    param($Uri)

    Invoke-RestMethod -Uri 'google.com'
}

Describe "Command returns expected output" {
    
    Mock Invoke-RestMethod -MockWith {
         $foo = [pscustomobject]@{
               id = 4
               name = 'Things'
               permalink = 'customer-support'
               position = 4 
               description = $null
               created_at = (Get-Date).ToLongTimeString()
               updated_at = (Get-Date).ToLongTimeString()
               status = [pscustomobject]@{
                   id = 1
                   name = 'Operational'
                   permalink = 'Operational'
                   color = '2fcc66'
                   status_type = 'ok'
                   created_at = (Get-Date).ToLongTimeString()
                   updated_at = (Get-Date).ToLongTimeString()
               }
        }

        return $foo
    } 

    It "Returns a name" {
        $service = Get-StaytusService
        $service.name | Should -Be 'Things'
    }

    It "Has an id" {
        $service = Get-StaytusService
        $service.id | Should -Be 4
    }

    It "Has a permalink" {
        $service = Get-StaytusService
        $service.permalink | Should -Be 'customer-support'
    }

    It "Has a position" {
        $service = Get-StaytusService
        $service.position | Should -Be 4
    }

    It "Has a blank description" {
        $service = Get-StaytusService
        $service.description | Should -BeNullOrEmpty
    }

    It "Status is a pscustomobject" {
        $service = Get-StaytusService
        $service.status | Should -BeOfType "System.Management.Automation.PSCustomObject"
    }
}