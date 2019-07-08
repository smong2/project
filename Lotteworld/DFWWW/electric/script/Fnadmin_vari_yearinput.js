<!--
function FnDate() {
var Year=document.form.sltyear.options[form.sltyear.selectedIndex].value;
var locate='admin_vari_yearinput.asp?varview=ok&sltYear=' + Year
location=locate;
}
function Fncheck() {
if (document.form.sltyear.value=="") {
   alert("년도 선택은 필수입니다");
   return false;
 }
if (document.form.txtPopNationalAdult.value=="") { 
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
 }
if (document.form.txtPopMetropolis.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
 }
if (document.form.txtPopSeoulSchool.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
 }
if (document.form.txtPopSeoulChild.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
 }
if (document.form.txtConstruction.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
 }
if (document.form.txtDistribution.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
 }
if (document.form.txtFinancial.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
 }
if (document.form.txtGNI.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
 }
if (document.form.txtHOSTS.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
 }
if (document.form.txtKOSPI.value=="") { 
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
 }
if (document.form.txtManufacturing.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
 }
if(confirm("전송하시겠습니까?")) 
   return true;
  else	
   return false;
}
-->