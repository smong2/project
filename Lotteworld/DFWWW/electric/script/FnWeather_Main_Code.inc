<%
FUNCTION FnWeatherCode(Wcode)

IF Wcode=1 THEN
FnWeatherCode="¸¼À½"
ELSEIF Wcode=2 THEN
FnWeatherCode="±¸¸§Á¶±Ý"
ELSEIF Wcode=3 THEN
FnWeatherCode="±¸¸§¸¹À½"
ELSEIF Wcode=4 THEN
FnWeatherCode="Èå¸²"
ELSEIF Wcode=5 THEN
FnWeatherCode="ºñ"
ELSEIF Wcode=6 THEN
FnWeatherCode="´«"
ELSEIF Wcode=7 THEN
FnWeatherCode="°·"
ELSEIF Wcode=8 THEN
FnWeatherCode="¼Ò³ª±â"
ELSEIF Wcode=9 THEN
FnWeatherCode="ºñ¶Ç´Â´«"
ELSEIF Wcode=10 THEN
FnWeatherCode="´«¶Ç´Âºñ"
ELSEIF Wcode=11 THEN
FnWeatherCode="ÃµµÕ¹ø°³"
ELSEIF Wcode=12 THEN
FnWeatherCode="¾È°³"
END IF
END FUNCTION
%>
