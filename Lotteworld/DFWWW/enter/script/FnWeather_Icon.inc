<% 
DIM Icon_40,code
DIM WEATHER_VALUE
FUNCTION FnWeatherIcon(weather_value)

'40�� ������ �ٲٴ� �κ�
'�ҳ���
IF (instr(weather_value,"�ҳ���")) THEN    
'code="�ҳ���"
	IF (instr(weather_value,"����") or instr(weather_value,"��ħ") or instr(weather_value,"����")) THEN 
			icon_40="08"
    ELSEIF (instr(weather_value,"����") or instr(weather_value,"��") or instr(weather_value,"����") or instr(weather_value,"��")) THEN
			icon_40="09"
    ELSE 
			icon_40="07"
    END IF  '�ҳ��� ����


'��/��/��   '�ҳ��� ���� �޴�
code="��/��/��"
ELSEIF (instr(weather_value,"�� ") and instr(weather_value,"��") and instr(weather_value,"��")) THEN

	IF (instr(weather_value,"����") or instr(weather_value,"��ħ") or instr(weather_value,"����")) THEN
			icon_40="37"
	ELSEIF (instr(weather_value,"����") or instr(weather_value,"��") or instr(weather_value,"����") or instr(weather_value,"��")) THEN
			icon_40="38"
	ELSE 
	        icon_40="36"
	END IF '�񴫰� ����


'�� ��/��/�� ���� �޴�
ELSEIF (instr(weather_value,"��")) THEN
code="��"
     IF (instr(weather_value,"��/��") or instr(weather_value,"��Ǵ´�")) THEN

            IF (instr(weather_value,"����") or instr(weather_value,"->")) THEN

              	IF (instr(weather_value,"����") or instr(weather_value,"��") or instr(weather_value,"����") or instr(weather_value,"��")) THEN 
              			icon_40="30"
              	ELSE
              			icon_40="29"
				END IF  '���� ����

            ELSEIF (instr(weather_value,"����") or instr(weather_value,"��ħ") or instr(weather_value,"����")) THEN icon_40="27"
            ELSEIF (instr(weather_value,"����") or instr(weather_value,"��") or instr(weather_value,"����") or instr(weather_value,"��")) THEN 
					icon_40="28"
            ELSE 
					icon_40="26"
            END IF '���� ����

	ELSEIF (instr(weather_value,"��/��") or instr(weather_value,"���Ǵº�")) THEN  '��Ǵ´� ����
		code="���Ǵº�"
			IF (instr(weather_value,"����") or instr(weather_value,"->")) THEN

           		IF (instr(weather_value,"����") or instr(weather_value,"��") or instr(weather_value,"����") or instr(weather_value,"��")) THEN 
           				icon_40="35"
       				ELSE 
	       				icon_40="34"
				END IF '���� ����

			ELSEIF (instr(weather_value,"����") or instr(weather_value,"��ħ") or instr(weather_value,"����")) THEN 
				icon_40="32"
			ELSEIF (instr(weather_value,"����") or instr(weather_value,"��") or instr(weather_value,"����") or instr(weather_value,"��")) THEN 
				icon_40="33"
			ELSE
				icon_40="31"
			END IF  '���� ����

	ELSEIF (instr(weather_value,"����") or instr(weather_value,"->")) THEN '��Ǵ´� ����
		code="���� �ø���"
			IF(instr(weather_value,"����") or instr(weather_value,"��") or instr(weather_value,"����") or instr(weather_value,"��")) THEN
				icon_40="22"
			ELSE 
				icon_40="21"
			END IF '���� ����

	ELSE IF(instr(weather_value,"��") or instr(weather_value,"=>")) THEN '��Ǵ´� ����
            if(instr(weather_value,"����") or instr(weather_value,"��ħ") or instr(weather_value,"����")) THEN
               icon_40="24"
            elseif(instr(weather_value,"����") or instr(weather_value,"��") or instr(weather_value,"����") or instr(weather_value,"��")) THEN
			   icon_40="25"
            else 
               icon_40="23"
            END IF '���� ����
              
			elseif(instr(weather_value,"����") or instr(weather_value,"��ħ") or instr(weather_value,"����")) THEN
				icon_40="19"
			elseif(instr(weather_value,"����") or instr(weather_value,"��") or instr(weather_value,"����") or instr(weather_value,"��")) THEN
				icon_40="20"
	        else 
				icon_40="18"
            END IF  '���� ����
END IF
ELSEIF(instr(weather_value,"��")) THEN

           IF (instr(weather_value,"��") or instr(weather_value,"=>")) THEN
               IF (instr(weather_value,"����") or instr(weather_value,"��ħ") or instr(weather_value,"����")) THEN
				icon_40="16"
               ELSEIF (instr(weather_value,"����") or instr(weather_value,"��") or instr(weather_value,"����") or instr(weather_value,"��")) THEN
                icon_40="17"
               ELSE
                icon_40="15"
               END IF

           ELSEIF(instr(weather_value,"����") or instr(weather_value,"->")) THEN
               IF(instr(weather_value,"����") or instr(weather_value,"��") or instr(weather_value,"����") or instr(weather_value,"��")) THEN
                icon_40="14"
               ELSE
                icon_40="13"
               END IF

           ELSEIF(instr(weather_value,"����") or instr(weather_value,"��ħ") or instr(weather_value,"����")) THEN
				icon_40="11"

           ELSEIF(instr(weather_value,"����") or instr(weather_value,"��") or instr(weather_value,"����") or instr(weather_value,"��")) THEN
				icon_40="12"

           ELSE
				icon_40="10"
           END IF

ELSEIF (instr(weather_value,"������") OR instr(weather_value,"����->")) THEN 
	icon_40="06"

ELSEIF(instr(weather_value,"����")) THEN
	icon_40="01"

ELSEIF(instr(weather_value,"��������")) THEN
	icon_40="02"

ELSEIF(instr(weather_value,"������")) THEN
	icon_40="03"

ELSEIF(instr(weather_value,"�帰��") OR instr(weather_value,"�帲��") OR instr(weather_value,"��") OR instr(weather_value,"����������") OR instr(weather_value,"������")) THEN
    icon_40="05"

ELSEIF(instr(weather_value,"�帲") OR instr(weather_value,"�����")) THEN
	icon_40="04"

ELSEIF(instr(weather_value,"õ��") OR instr(weather_value,"����")) THEN 
	icon_40="39"
END IF

FnWeatherIcon=icon_40
END FUNCTION
%>