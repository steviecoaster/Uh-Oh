# Uh-Oh: The PowerShell module for Staytus!

[Staytus](http://staytus.co/) is an awesome open-source status page software for notifying stakeholders of outages for services you provide.

Print Server gone on the fritz? Database corrupted? Web site throwin' a wobbler? Staytus allows you to quickly post incident updates to a nice WebUI enabling visibility into service degradation issues to your users.

---

## Installation

### From Source

```powershell
git clone https://github.com/steviecoaster/Uh-Oh.git
cd Uh-Oh
./build.ps1 -Build
Import-Module ./Uh-Oh.psd1
```

### PowerShell Gallery : COMING SOON

```powershell
Install-Module Uh-Oh
```

### Chocolatey : COMING SOON

```powershell
choco install uh-oh -y
```
