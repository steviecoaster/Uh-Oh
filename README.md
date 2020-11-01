# Uh-Oh: The PowerShell module for Staytus!

[![Build status](https://dev.azure.com/chocopackages/AutomaticPackages/_apis/build/status/Uh-Oh)](https://dev.azure.com/chocopackages/AutomaticPackages/_build/latest?definitionId=5)

[Staytus](http://staytus.co/) is an awesome open-source status page software for notifying stakeholders of outages for services you provide.

Print Server gone on the fritz? Database corrupted? Web site throwin' a wobbler? Staytus allows you to quickly post incident updates to a nice WebUI enabling visibility into service degradation issues to your users.

---

## Installation

### From Source

```powershell
git clone https://github.com/steviecoaster/Uh-Oh.git
cd Uh-Oh
./build.ps1 -Build
Import-Module ./Output/Uh-Oh/Uh-Oh.psd1
```

### PowerShell Gallery

```powershell
Install-Module Uh-Oh
```

### Chocolatey : COMING SOON (In Moderation)

```powershell
choco install uh-oh -y
```
