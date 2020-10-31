---
external help file: Uh-Oh-help.xml
Module Name: Uh-Oh
online version:
schema: 2.0.0
---

# New-StaytusIncident

## SYNOPSIS
Post a new incident to Staytus

## SYNTAX

```
New-StaytusIncident [-Title] <String> [-Service] <String[]> [-Status] <String> [-State] <String>
 [-NotifySubscribers] [-UseSSL] [<CommonParameters>]
```

## DESCRIPTION
Post a new service incident to your Staytus instance

## EXAMPLES

### EXAMPLE 1
```
New-StaytusIncident -Credential $credential -StaytusServer 192.168.2.239:8787 -Title 'PowerShell Test' -Service Junk 
-State Identified -Status major-outage
```

### EXAMPLE 2
```
$incidentParams = @{
    Credential = $credential
    StaytusServer = 192.168.2.239:8787
    Title = 'Well, that's not good. SQL is down!'
    Service = 'Sql Cluster'
    State = 'Identified'
    Status = 'major-outage'
}
```

New-StaytusIncident @incidentParams

## PARAMETERS

### -Title
The incident Title

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

### -Service
The affected Service

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
Current Status

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -State
Current State

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NotifySubscribers
Send email to subscribers

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

### -UseSSL
Use SSL in URI.
If using non-standard HTTPS port, ensure 'hostname:port' format of StaytusServer is correct

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
