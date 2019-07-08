function FnDate() {
var Year=document.form.sltInput_Year.options[form.sltInput_Year.selectedIndex].value;
var Month=document.form.sltInput_Month.options[form.sltInput_Month.selectedIndex].value;
var Day=document.form.sltInput_Day.options[form.sltInput_Day.selectedIndex].value;
var varmode=document.form.sltMode.value;
var locate='admin_results_input.asp?varview=ok&sltYear=' + Year + '&sltMonth=' + Month + '&sltDay=' + Day + '&sltMode=' + varmode
location=locate;
}
function fncheck() {
if (document.form.sltInput_Year.value=="") {
 alert("년을 선택해주십시오");
 return false;
}
if (document.form.sltInput_Month.value=="") {
 alert("월을 선택해주십시오");
 return false;
}
if (document.form.sltInput_Day.value=="") {
 alert("일을 선택해주십시오");
 return false;
}
if (document.form.txtMagicisland.value=="") {
 if(confirm("매직아일랜드가 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
}
if (document.form.txtAdventure.value=="") {
 if(confirm("어드벤처가 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
}
if (document.form.txtSports.value=="") {
 if(confirm("스포츠가 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
}
if (document.form.txtHotel.value=="") {
 if(confirm("호텔이 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
}
if (document.form.txtDepartmentstore.value=="") {
 if(confirm("백화점이 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
}
if (document.form.txtShoppingmall.value=="") {
 if(confirm("쇼핑몰이입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
}
if (document.form.txtMart.value=="") {
 if(confirm("마트가 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
}
if (document.form.txtTotal.value=="") {
 if(confirm("합계가 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
}
if(confirm("전송하시겠습니까?")) 
   return true;
  else	
   return false;
}