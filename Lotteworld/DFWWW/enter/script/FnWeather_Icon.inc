<% 
DIM Icon_40,code
DIM WEATHER_VALUE
FUNCTION FnWeatherIcon(weather_value)

'40개 아이콘 바꾸는 부분
'소나기
IF (instr(weather_value,"소나기")) THEN    
'code="소나기"
	IF (instr(weather_value,"새벽") or instr(weather_value,"아침") or instr(weather_value,"오전")) THEN 
			icon_40="08"
    ELSEIF (instr(weather_value,"오후") or instr(weather_value,"밤") or instr(weather_value,"저녁") or instr(weather_value,"낮")) THEN
			icon_40="09"
    ELSE 
			icon_40="07"
    END IF  '소나기 서브


'비/눈/갬   '소나기 다음 메뉴
code="비/눈/갬"
ELSEIF (instr(weather_value,"비 ") and instr(weather_value,"눈") and instr(weather_value,"갬")) THEN

	IF (instr(weather_value,"새벽") or instr(weather_value,"아침") or instr(weather_value,"오전")) THEN
			icon_40="37"
	ELSEIF (instr(weather_value,"오후") or instr(weather_value,"밤") or instr(weather_value,"저녁") or instr(weather_value,"낮")) THEN
			icon_40="38"
	ELSE 
	        icon_40="36"
	END IF '비눈갬 서브


'눈 비/눈/갬 다음 메뉴
ELSEIF (instr(weather_value,"눈")) THEN
code="눈"
     IF (instr(weather_value,"비/눈") or instr(weather_value,"비또는눈")) THEN

            IF (instr(weather_value,"차차") or instr(weather_value,"->")) THEN

              	IF (instr(weather_value,"오후") or instr(weather_value,"밤") or instr(weather_value,"저녁") or instr(weather_value,"낮")) THEN 
              			icon_40="30"
              	ELSE
              			icon_40="29"
				END IF  '오후 서브

            ELSEIF (instr(weather_value,"새벽") or instr(weather_value,"아침") or instr(weather_value,"오전")) THEN icon_40="27"
            ELSEIF (instr(weather_value,"오후") or instr(weather_value,"밤") or instr(weather_value,"저녁") or instr(weather_value,"낮")) THEN 
					icon_40="28"
            ELSE 
					icon_40="26"
            END IF '차차 서브

	ELSEIF (instr(weather_value,"눈/비") or instr(weather_value,"눈또는비")) THEN  '비또는눈 연속
		code="눈또는비"
			IF (instr(weather_value,"차차") or instr(weather_value,"->")) THEN

           		IF (instr(weather_value,"오후") or instr(weather_value,"밤") or instr(weather_value,"저녁") or instr(weather_value,"낮")) THEN 
           				icon_40="35"
       				ELSE 
	       				icon_40="34"
				END IF '오후 서브

			ELSEIF (instr(weather_value,"새벽") or instr(weather_value,"아침") or instr(weather_value,"오전")) THEN 
				icon_40="32"
			ELSEIF (instr(weather_value,"오후") or instr(weather_value,"밤") or instr(weather_value,"저녁") or instr(weather_value,"낮")) THEN 
				icon_40="33"
			ELSE
				icon_40="31"
			END IF  '차차 서브

	ELSEIF (instr(weather_value,"차차") or instr(weather_value,"->")) THEN '비또는눈 연속
		code="차차 시리즈"
			IF(instr(weather_value,"오후") or instr(weather_value,"밤") or instr(weather_value,"저녁") or instr(weather_value,"낮")) THEN
				icon_40="22"
			ELSE 
				icon_40="21"
			END IF '오후 서브

	ELSE IF(instr(weather_value,"갬") or instr(weather_value,"=>")) THEN '비또는눈 연속
            if(instr(weather_value,"새벽") or instr(weather_value,"아침") or instr(weather_value,"오전")) THEN
               icon_40="24"
            elseif(instr(weather_value,"오후") or instr(weather_value,"밤") or instr(weather_value,"저녁") or instr(weather_value,"낮")) THEN
			   icon_40="25"
            else 
               icon_40="23"
            END IF '새벽 서브
              
			elseif(instr(weather_value,"새벽") or instr(weather_value,"아침") or instr(weather_value,"오전")) THEN
				icon_40="19"
			elseif(instr(weather_value,"오후") or instr(weather_value,"밤") or instr(weather_value,"저녁") or instr(weather_value,"낮")) THEN
				icon_40="20"
	        else 
				icon_40="18"
            END IF  '새벽 서브
END IF
ELSEIF(instr(weather_value,"비")) THEN

           IF (instr(weather_value,"갬") or instr(weather_value,"=>")) THEN
               IF (instr(weather_value,"새벽") or instr(weather_value,"아침") or instr(weather_value,"오전")) THEN
				icon_40="16"
               ELSEIF (instr(weather_value,"오후") or instr(weather_value,"밤") or instr(weather_value,"저녁") or instr(weather_value,"낮")) THEN
                icon_40="17"
               ELSE
                icon_40="15"
               END IF

           ELSEIF(instr(weather_value,"차차") or instr(weather_value,"->")) THEN
               IF(instr(weather_value,"오후") or instr(weather_value,"밤") or instr(weather_value,"저녁") or instr(weather_value,"낮")) THEN
                icon_40="14"
               ELSE
                icon_40="13"
               END IF

           ELSEIF(instr(weather_value,"새벽") or instr(weather_value,"아침") or instr(weather_value,"오전")) THEN
				icon_40="11"

           ELSEIF(instr(weather_value,"오후") or instr(weather_value,"밤") or instr(weather_value,"저녁") or instr(weather_value,"낮")) THEN
				icon_40="12"

           ELSE
				icon_40="10"
           END IF

ELSEIF (instr(weather_value,"맑은후") OR instr(weather_value,"맑음->")) THEN 
	icon_40="06"

ELSEIF(instr(weather_value,"맑음")) THEN
	icon_40="01"

ELSEIF(instr(weather_value,"구름조금")) THEN
	icon_40="02"

ELSEIF(instr(weather_value,"구름많")) THEN
	icon_40="03"

ELSEIF(instr(weather_value,"흐린후") OR instr(weather_value,"흐림후") OR instr(weather_value,"갬") OR instr(weather_value,"차차맑아짐") OR instr(weather_value,"맑아짐")) THEN
    icon_40="05"

ELSEIF(instr(weather_value,"흐림") OR instr(weather_value,"흐려짐")) THEN
	icon_40="04"

ELSEIF(instr(weather_value,"천둥") OR instr(weather_value,"번개")) THEN 
	icon_40="39"
END IF

FnWeatherIcon=icon_40
END FUNCTION
%>