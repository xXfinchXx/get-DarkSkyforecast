function Get-WUforecast {
    <#
    .SYNOPSIS
    Call the Weather Underground API - Basic Weather Forecast/One Day
    
    .DESCRIPTION
    One day forecast from Weather Underground from the Stratus level API key.
    
    .PARAMETER apikey
    Must sign up for an API key from https://www.wunderground.com/weather/api
    
    .PARAMETER Zip
    Zip Code for where you would like to see the weather.
    
    .EXAMPLE
    Invoke-WeatherUnderground -apikey [parameter] -zip [parameter]
    #>
    param(
        [string]$apikey,
        [string]$Zip
    )
    Begin{
        IF ($APIKEY -eq $null)
            {
                Write-Host ""
                Write-Warning "You have not set your API Key!"
                Write-Host "Please go to https://www.wunderground.com/weather/api to get your API key - it's free."
                Write-Host "Once you have your key, change the value in the $" -nonewline; Write-Host "API variable with your key and re-run this script."
                Write-Host ""
            exit
            }

        $location = Invoke-RestMethod -uri "http://api.wunderground.com/api/$($APIKEY)/geolookup/q/$($Zip).json"
        $weather = Invoke-RestMethod -URI "http://api.wunderground.com/api/$($APIKEY)/forecast/q/$($location.location.state)/$($location.location.city).json"
        $high = "Today's High: " + $weather.forecast.simpleforecast.forecastday[0].high.fahrenheit + "f"
        $low = "Today's Low: " + $weather.forecast.simpleforecast.forecastday[0].low.fahrenheit + "f"
        $humidity = "Humidity: " + $weather.forecast.simpleforecast.forecastday[0].avehumidity + "%"
        $precipitation = If($weather.forecast.simpleforecast.forecastday[0].qpf_allday.in -match "0.00")
            {
                "Precipitation: No Precipitation"
            } else {
                "Precipitation:" + $weather.forecast.simpleforecast.forecastday[0].qpf_allday.in + "inches of rain"
            }
        $windSpeed = "Wind Speed: " + $weather.forecast.simpleforecast.forecastday[0].avewind.mph + " mp/h" + " - Direction: " + $weather.forecast.simpleforecast.forecastday[0].avewind.dir
        $currentcondition = "Conditions:" + $weather.forecast.simpleforecast.forecastday[0].conditions
    }
    Process{
        Write-Host ""
        Write-Host "Current weather conditions for"$($location.location.city) $($location.location.state);
        Write-Host "Last Updated:" -nonewline; Write-Host "" $weather.forecast.txt_forecast.date -f yellow;
        Write-Host "For Today:"  -NoNewline; Write-Host "" $weather.forecast.txt_forecast.forecastday.fcttext[0]
        Write-Host ""
        IF ($currentcondition -match 'thunderstorm')
            {	
        	    Write-Host "	    .--.   		" -f gray -nonewline;   Write-Host "$high		$humidity" -f white;
        	    Write-Host "	 .-(    ). 		" -f gray -nonewline;   Write-Host "$low		$precipitation" -f white;
        	    Write-Host "	(___.__)__)		" -f gray -nonewline;   Write-Host "$Currentcondition" -f white;
        	    Write-Host "	  /_   /_  		" -f yellow -nonewline; Write-Host "$windspeed" -f white; 
        	    Write-Host "	   /    /  		" -f yellow; 
        	    Write-Host ""
            }
        ELSEIF ($currentcondition -match 'drizzle')
        	{
        		Write-Host "	  .-.   		" -f gray -nonewline; Write-Host "$high     $humidity" -f white;
        		Write-Host "	 (   ). 		" -f gray -nonewline; Write-Host "$low      $precipitation" -f white;
        		Write-Host "	(___(__)		" -f gray -nonewline; Write-Host "$Currentcondition" -f white;
        		Write-Host "	 / / / 			" -f cyan -NoNewline; Write-Host "$windspeed" -f white;
        		Write-Host "	  /  			" -f cyan ; 
        		Write-Host ""
        	}
        ELSEIF  ($currentcondition -match 'rain')
        	{
        		Write-Host "	    .-.   		" -f gray -nonewline; Write-Host "$high		$humidity" -f white;
        		Write-Host "	   (   ). 		" -f gray -nonewline; Write-Host "$low		$precipitation" -f white;
        		Write-Host "	  (___(__)		" -f gray -nonewline; Write-Host "$Currentcondition" -f white;
        		Write-Host "	 //////// 		" -f cyan -NoNewline; Write-Host "$windspeed" -f white;
        		Write-Host "	 /////// 		" -f cyan ; 
        		Write-Host ""
        	}
        ELSEIF  ($currentcondition -match 'clear')
        	{
        		Write-Host "	   \ | /  		" -f Yellow -nonewline; Write-Host "$high		$humidity" -f white;
        		Write-Host "	    .-.   		" -f Yellow -nonewline; Write-Host "$low		$precipitation" -f white;
        		Write-Host "	-- (   ) --		" -f Yellow -nonewline; Write-Host "$Currentcondition" -f white;
        		Write-Host "	    *-*   	    " -f Yellow -NoNewline; Write-Host "$windspeed" -f white;
        		Write-Host "	   / | \  		" -f yellow ; 
        		Write-Host ""
        	}
        ELSEIF ($currentcondition -match 'partly cloudy')
        	{
        		Write-Host "	   \ | /   		" -f Yellow -nonewline; Write-Host "$high		$humidity" -f white;
        		Write-Host "	    .-.    		" -f Yellow -nonewline; Write-Host "$low		$precipitation" -f white;
        		Write-Host "	-- (  .--. 		" -f Yellow -nonewline; Write-Host "$Currentcondition" -f white;
                Write-Host "	   .-(    ). 	" -f gray -NoNewline  ; Write-Host "$windspeed" -f white;
        		Write-Host "	  (___.__)__)	" -f gray;			
        		Write-Host ""
        	}
        ELSEIF ($currentcondition -match 'cloudy')
        	{
        	    Write-Host "	    .--.   		" -f gray -NoNewline;Write-Host "$high		$humidity"
        	    Write-Host "	 .-(    ). 		" -f gray -NoNewline;Write-Host "$low		$precipitation"
        	    Write-Host "	(___.__)__)		" -f gray -NoNewline;Write-Host "$Currentcondition" -f white;
		        Write-Host "	            	" -f gray -NoNewline;Write-Host "$windspeed" -f white;
		        Write-Host "					" -f gray ;
		        Write-Host ""
		    }
	    ELSEIF ($currentcondition -match 'windy')
		    {
		        Write-Host "	~~~~      .--.   " -f gray -NoNewline;Write-Host "$high		$humidity"
		        Write-Host "	 ~~~~~ .-(    ). " -f gray -NoNewline;Write-Host "$low		$precipitation"
		        Write-Host "	~~~~~ (___.__)__)" -f gray -NoNewline;Write-Host "$Currentcondition" -f white;
		        Write-Host "	                 " -f gray -NoNewline;Write-Host "$windspeed" -f white;
		        Write-Host ""
        }
    }    
}