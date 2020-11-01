---
external help file: Uh-Oh-help.xml
Module Name: Uh-Oh
online version:
schema: 2.0.0
---

# Get-StaytusService

## SYNOPSIS
Return Service information for services defined in Staytus

## SYNTAX

```
Get-StaytusService [[-Service] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Return Service information for services defined in Staytus

## EXAMPLES

### EXAMPLE 1
```
Return all service details
```

Get-StaytusService

### EXAMPLE 2
```
Return service details for given service(s)
```

Get-StaytusService -Service Storefront

### EXAMPLE 3
```
Get-StaytusService -Service Storefront,Sql
```

## PARAMETERS

### -Service
The Service to interrogate

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
