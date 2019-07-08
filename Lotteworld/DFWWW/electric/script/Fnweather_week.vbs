<script language=vbscript runat=server>
FUNCTION FnWeather_Date_Title(WDATE)
FnWeather_Date_Title=left(WDATE,4) & "³â" & mid(WDATE,5,2) & "¿ù" & right(WDATE,2) & "ÀÏ"
END FUNCTION

FUNCTION FnWeather_Week_Date(WDATE)
FnWeather_Week_Date=right(WDATE,2) & "(" & left(weekdayname(weekday(dateserial(left(WDATE,4),mid(WDATE,5,2),right(WDATE,2)))),1) & ")"
END FUNCTION
</script>