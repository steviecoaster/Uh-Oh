---
external help file: Uh-Oh-help.xml
Module Name: Uh-Oh
online version:
schema: 2.0.0
---

# Connect-StaytusServer

## SYNOPSIS
Establishes session connection details for Staytus Server

## SYNTAX

```
Connect-StaytusServer [-StaytusServer] <String> [-UseSSL] [-Credential] <PSCredential> [<CommonParameters>]
```

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

### -StaytusServer
Hostname of Staytus server.
If non-standard port use hostname:port format

```yaml
Type: String
Parameter Sets: (All)
Aliases: Hostname

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSSL
Toggle using HTTPS as protocol.
If non-standard SSL port is in use, ensure hostname:port is used in StaytusServer parameter

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

### -Credential
X-Auth-Token (username) and X-Auth-Secret (password) for Staytus api user

```yaml
Type: PSCredential
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
General notes

## RELATED LINKS
