---
external help file: EleadWeather-help.xml
Module Name: EleadWeather
online version:
schema: 2.0.0
---

# Get-WUforecast

## SYNOPSIS
Call the Weather Underground API - Basic Weather Forecast/One Day

## SYNTAX

```powershell
Get-WUforecast [[-apikey] <String>] [[-Zip] <String>]
```

## DESCRIPTION
One day forecast from Weather Underground from the Stratus level API key.

## EXAMPLES

### EXAMPLE 1
```powershell
Invoke-WeatherUnderground -apikey [parameter] -zip [parameter]
```

## PARAMETERS

### -apikey
Must sign up for an API key from https://www.wunderground.com/weather/api

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

### -Zip
Zip Code for where you would like to see the weather.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
