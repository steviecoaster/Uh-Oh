---
external help file: Uh-Oh-help.xml
Module Name: Uh-Oh
online version:
schema: 2.0.0
---

# Get-PoshBotStaytusIncident

## SYNOPSIS
Establishes session connection details for Staytus Server

## SYNTAX

## DESCRIPTION
Establishes session connection details for Staytus Server

## EXAMPLES

### EXAMPLE 1
```
Connect-StaytusServer -StaytusServer staytus.contoso.com:8787 -Credential (Get-Credential)
```

### EXAMPLE 2
```
Connect-StaytusServer -StaytusServer staytus.contoso.com -Credential $credential
```

### EXAMPLE 3
```
Connect-StaytusServer -StaytusServer staytus.contoso.com -Credential $credential -UseSSL
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
General notes

## RELATED LINKS
