<%
FUNCTION FNWeatherCode(WeatherCode)
	IF len(WeatherCode)=1 THEN
		FNWeatherCode="0" & WeatherCode
	ELSE
	FNWeatherCode=WeatherCode
	END IF
END FUNCTION

FUNCTION FnWeatherBarHeightRain(WeatherCode)
	FnWeatherBarHeightRain=FormatNumber(70*FormatNumber(WeatherCode,0)/100,0)	
END FUNCTION

FUNCTION FnWeatherBarHeightTemp(WeatherCode)
	FnWeatherBarHeightTemp=FormatNumber(70*FormatNumber(WeatherCode,0)/60,0)+20
END FUNCTION

SUB FnMovingPointer
 rs.MOVEPREVIOUS : rs.MOVEPREVIOUS : rs.MOVEPREVIOUS : rs.MOVEPREVIOUS
END SUB
%>