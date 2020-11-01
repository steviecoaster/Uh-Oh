---
external help file: Uh-Oh-help.xml
Module Name: Uh-Oh
online version:
schema: 2.0.0
---

# New-PoshBotStaytusIncident

## SYNOPSIS
Returns incident data for Staytus events

## SYNTAX

## DESCRIPTION
Returns detailed status information for incidents raised in your Staytus system

## EXAMPLES

### EXAMPLE 1
```
Get-StaytusIncident
```

### EXAMPLE 2
```
Get-StaytusIncident -Id 1,36,4
```

### EXAMPLE 3
```
Get-STaytusIncident -Title 'Website experiencing slow response','SQL Database degraded'
```

### EXAMPLE 4
```
Get-StaytusIncident -State Identified,Investigating
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
