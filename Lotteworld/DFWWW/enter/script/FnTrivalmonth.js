function namosw_goto_byselect(sel, targetstr)
{
  var index = sel.selectedIndex;
  if (sel.options[index].value != '') {
     if (targetstr == 'blank') {
       window.open(sel.options[index].value, 'win1');
     } else {
       var frameobj;
       if (targetstr == '') targetstr = 'self';
       if ((frameobj = eval(targetstr)) != null)
         frameobj.location = sel.options[index].value;
     }
  }
}
function FnDate() {
var Year=document.form.sltInput_year.options[form.sltInput_year.selectedIndex].value;
var Month=document.form.sltInput_month.options[form.sltInput_month.selectedIndex].value;
var locate='admin_results_rival.asp?varview=ok&sltYear=' + Year + '&sltMonth=' + Month
location=locate;
}
function Fncheck() {
if (document.form.sltInput_year.value=="") {    
 alert("년 선택은 필수입니다.");
 return false;
 }
if (document.form.sltInput_month.value=="") {    
 alert("월 선택은 필수입니다.");
 return false;
 }
if (document.form.txtIndivadultever.value=="") {    
 alert("에버랜드 개인-어른란을 채워주세요");
 document.form.txtIndivadultever.focus();
 return false;
 }
if (document.form.txtIndivschoolever.value=="") {
 alert("에버랜드 개인-중고생란을 채워주세요");
 document.form.txtIndivschoolever.focus();
 return false;
 }
if (document.form.txtIndivchildever.value=="") {
 alert("에버랜드 개인-어린이란을 채워주세요");
 document.form.txtIndivchildever.focus();
 return false;
 } 
if (document.form.txtGroupadultever.value=="") {
 alert("에버랜드 단체-어른란을 채워주세요");
 document.form.txtGroupadultever.focus();
 return false;
 } 
if (document.form.txtGroupschoolever.value=="") {
 alert("에버랜드 단체-중고생란을 채워주세요");
 document.form.txtGroupschoolever.focus();
 return false;
 } 
if (document.form.txtGroupchildever.value=="") {
 alert("에버랜드 단체-어린이란을 채워주세요");
 document.form.txtGroupchildever.focus();
 return false;
 } 
if (document.form.txtIndivadultseoul.value=="") {
 alert("서울랜드 개인-어른란을 채워주세요");
 document.form.txtIndivadultseoul.focus();
 return false;
 }
if (document.form.txtIndivschoolseoul.value=="") {
 alert("서울랜드 개인-중고생란을 채워주세요");
 document.form.txtIndivschoolseoul.focus();
 return false;
 }
if (document.form.txtIndivchildseoul.value=="") {
 alert("서울랜드 개인-어린이란을 채워주세요");
 document.form.txtIndivchildseoul.focus();
 return false;
 } 
if (document.form.txtGroupadultseoul.value=="") {
 alert("서울랜드 단체-어른란을 채워주세요");
 document.form.txtGroupadultseoul.focus();
 return false;
 } 
if (document.form.txtGroupschoolseoul.value=="") {
 alert("서울랜드 단체-중고생란을 채워주세요");
 document.form.txtGroupschoolseoul.focus();
 return false;
 } 
if (document.form.txtGroupchildseoul.value=="") {
 alert("서울랜드 단체-어린이란을 채워주세요");
 document.form.txtGroupchildseoul.focus();
 return false;
 }  
if(confirm("전송하시겠습니까?")) 
   return true;
  else	
   return false;
}
