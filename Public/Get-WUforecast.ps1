function Get-DarkSkyforecast {
    <#
    .SYNOPSIS
    Call the DarkSky API - Basic Weather Forecast/One Day
    
    .DESCRIPTION
    One day forecast from DarkSky from the Stratus level API key.
    
    .PARAMETER apikey
    Must sign up for an API key from https://darksky.net/dev
    
    .PARAMETER Zip
    Zip Code for where you would like to see the weather.
    
    .EXAMPLE
    Get-DarkSkyforecast -apikey [parameter]
    #>
    param(
        [string]$apikey
    )
    Begin{
        IF ($APIKEY -eq $null)
            {
                Write-Host ""
                Write-Warning "You have not set your API Key!"
                Write-Host "Please go to https://darksky.net/dev to get your API key - it's free."
                Write-Host "Once you have your key, change the value in the $" -nonewline; Write-Host "API variable with your key and re-run this script."
                Write-Host ""
            exit
            }

        $ip = Invoke-RestMethod http://ipinfo.io/json | Select -exp ip

        $location = Invoke-RestMethod -uri "extreme-ip-lookup.com/json/$($IP)"
        $weather = Invoke-RestMethod -uri "https://api.darksky.net/forecast/$($APIKEY)/$($location.lat),$($location.lon)"
        $high = "Today's High: " + $weather.daily.data[0].temperatureHigh + " f"
        $low = "Today's Low: " + $weather.daily.data[0].temperaturelow + " f"
        $humidity = "Humidity: " + $Weather.currently.humidity + "%"
        $precipitation = If($weather.daily.data[0].precipIntensity -match "0.0000")
            {
                "Precipitation: No Precipitation"
            } else {
                "Precipitation: " + $weather.daily.data[0].precipIntensity + " inches of rain"
            }
        $windSpeed = "Wind Speed: " + $weather.currently.windspeed + " mp/h" + " - Gusts: " + $weather.currently.windGust + " mp/h"
        $currentcondition = "Conditions:" + $weather.currently.summary
    }
    Process{
        Write-Host ""
        Write-Host "Current weather conditions for" $($location.city) + $($location.region);
        Write-Host "Last Updated:" -nonewline; Write-Host "" (Get-Date).DateTime -f yellow;
        Write-Host "For Today:"  -NoNewline; Write-Host "" $weather.daily.data[0].summary
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
        ELSEIF ($currentcondition -match 'cloudy|overcast|Foggy')
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