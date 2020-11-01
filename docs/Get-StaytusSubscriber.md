---
external help file: Uh-Oh-help.xml
Module Name: Uh-Oh
online version:
schema: 2.0.0
---

# Get-StaytusSubscriber

## SYNOPSIS
Get Staytus Subscriber information

## SYNTAX

```
Get-StaytusSubscriber [[-EmailAddress] <String>] [[-VerificationToken] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get Staytus Subscriber information

## EXAMPLES

### EXAMPLE 1
```
Get-StaytusSubscriber -EmailAddress joe@widgetstore.com
```

### EXAMPLE 2
```
Get-StaytusSubscriber -VerificationToken 70b89737-e8de-437d-8fd0-4f043789474b
```

## PARAMETERS

### -EmailAddress
The email address to look-up

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VerificationToken
The verification token to look-up

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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
General notes

## RELATED LINKS
