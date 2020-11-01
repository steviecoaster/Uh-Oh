---
external help file: Uh-Oh-help.xml
Module Name: Uh-Oh
online version:
schema: 2.0.0
---

# Update-StaytusIncident

## SYNOPSIS
Updates an Incident in Staytus

## SYNTAX

```
Update-StaytusIncident [-Incident] <String> [-Update] <String> [[-Status] <String>] [[-State] <String>]
 [-NotifySubscribers] [<CommonParameters>]
```

## DESCRIPTION
Updates an Incident in Staytus

## EXAMPLES

### EXAMPLE 1
```
Update-StaytusIncident -Incident 'Website loading times degraded' -Update 'Still investigating'
```

## PARAMETERS

### -Incident
The Incident to update

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

### -Update
Provide a brief update about the incident

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

### -Status
Update status if needed

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -State
Update state if needed

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotifySubscribers
Send an email to subscribers

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
