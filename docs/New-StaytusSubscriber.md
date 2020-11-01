---
external help file: Uh-Oh-help.xml
Module Name: Uh-Oh
online version:
schema: 2.0.0
---

# New-StaytusSubscriber

## SYNOPSIS
Add a subscriber to Staytus

## SYNTAX

```
New-StaytusSubscriber [[-EmailAddress] <String>] [[-Verified] <String>] [<CommonParameters>]
```

## DESCRIPTION
Add a subscriber to Staytus

## EXAMPLES

### EXAMPLE 1
```
New-StaytusSubscriber -EmailAddress joe@widgetstore.com
```

### EXAMPLE 2
```
New-StaytusSubscriber -EmailAddress joe@widgetstore.com -Verified
```

## PARAMETERS

### -EmailAddress
The email address of the subscriber

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

### -Verified
Automatically mark the email address as verified

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

## RELATED LINKS
