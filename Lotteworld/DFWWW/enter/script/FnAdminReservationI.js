<!--
function Fncheck() {
if (document.form.sltYear.value=="") {
alert("년도를 선택해주십시오");
return false;
}
if (document.form.sltMonth.value==""){
alert("월을 선택해주십시오");
return false;
}
if (document.form.sltDay.value==""){
alert("일을 선택해주십시오");
return false;
}
if (document.form.txtAdult.value==""){
alert("어른을 입력해 주십시오");
document.form.txtAdult.focus();
return false;
}
if (document.form.txtSchool.value==""){
alert("중고생을 입력해 주십시오");
document.form.txtSchool.focus();
return false;
}
if (document.form.txtChild.value==""){
alert("어린이를 입력해 주십시오");
document.form.txtChild.focus();
return false;
}
if(confirm("전송하시겠습니까?")) 
   return true;
  else	
   return false;
}
function FnDate() {
var Year=document.form.sltYear.options[form.sltYear.selectedIndex].value;
var Month=document.form.sltMonth.options[form.sltMonth.selectedIndex].value;
var Day=document.form.sltDay.options[form.sltDay.selectedIndex].value;
var locate='admin_results_reservation.asp?varview=ok&sltYear=' + Year + '&sltMonth=' + Month + '&sltDay=' + Day
location=locate;
}
-->