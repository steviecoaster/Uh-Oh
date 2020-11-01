---
external help file: Uh-Oh-help.xml
Module Name: Uh-Oh
online version:
schema: 2.0.0
---

# Set-StaytusService

## SYNOPSIS
Set the status of a Staytus service

## SYNTAX

```
Set-StaytusService [-Service] <String> [-Status] <String> [<CommonParameters>]
```

## DESCRIPTION
Set the status of a Staytus service

## EXAMPLES

### EXAMPLE 1
```
Set-StaytusService -Service 'Storefront' -Status operational
```

## PARAMETERS

### -Service
The service to adjust

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
The status to set the service too

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
