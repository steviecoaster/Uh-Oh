---
external help file: Uh-Oh-help.xml
Module Name: Uh-Oh
online version:
schema: 2.0.0
---

# Get-StaytusIncident

## SYNOPSIS
Returns incident data for Staytus events

## SYNTAX

### Credential (Default)
```
Get-StaytusIncident [<CommonParameters>]
```

### Title
```
Get-StaytusIncident [-Title <String[]>] [<CommonParameters>]
```

### Id
```
Get-StaytusIncident [-Id <Int32[]>] [<CommonParameters>]
```

### State
```
Get-StaytusIncident [-State <String[]>] [<CommonParameters>]
```

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

### -Title
The Title of the incident to look for

```yaml
Type: String[]
Parameter Sets: Title
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The Id of the incident to look for

```yaml
Type: Int32[]
Parameter Sets: Id
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -State
The State of the incident to look for

```yaml
Type: String[]
Parameter Sets: State
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
