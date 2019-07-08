function FnDate() {
var Year=document.form.sltYear.options[form.sltYear.selectedIndex].value;
var Month=document.form.sltMonth.options[form.sltMonth.selectedIndex].value;
var locate='admin_vari_Monthinput.asp?varview=ok&sltYear=' + Year + '&sltMonth=' + Month
location=locate;
}
function Fncheck(form) {
if (document.form.sltYear.value=="") {
   alert("년도 선택은 필수입니다");
   return false;
 }
if (document.form.sltMonth.value=="") {
   alert("월 선택은 필수입니다");
   return false;
 }
if (document.form.sltGiantRoof.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
   }
if (document.form.sltGyroDrop.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
   }
if (document.form.sltGyroSwing.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
   }
if (document.form.sltIMF.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
   }
if (document.form.sltCard.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
   }
if (document.form.txtRepairIndex.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
   }
if (document.form.txtHosts.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
   }
if (document.form.txtSnowfall.value=="") {
 if(confirm("모든 항목이 다 입력되지 않았습니다. 그래도 전송하시겠습니까?")) 
   return true;
  else	
   return false;
   }    
if (document.form.txtDepartment.value=="") {
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
if (document.form.txtFinancial.value=="") {
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
if (document.form.txtConstruction.value=="") {
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