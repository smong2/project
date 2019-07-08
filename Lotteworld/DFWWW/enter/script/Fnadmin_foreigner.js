function FnDate() {
var Year=document.form.slt_Year.options[form.slt_Year.selectedIndex].value;
var Month=document.form.slt_Month.options[form.slt_Month.selectedIndex].value;
var locate='admin_results_foreigner.asp?varview=ok&sltYear=' + Year + '&sltMonth=' + Month
location=locate;
}

function Fncheck() {
if (document.form.slt_Year.value=="") {
 alert("년 입력은 필수입니다.");
 return false;
}
if (document.form.slt_Month.value=="") {
 alert("월 입력은 필수입니다.");
 return false;
}
if (document.form.txtTotal.value=="") {
 alert("합계를 입력해주세요");
 document.form.txtTotal.focus();
 return false;
}
if (document.form.txtJapan.value=="") {
 alert("일본인수를 입력해주세요");
 document.form.txtJapan.focus();
 return false;
}
if (document.form.txtTaiwan.value=="") {
 alert("대만인수를 입력해주세요");
 document.form.txtTaiwan.focus();
 return false;
}
if (document.form.txtSouthEast.value=="") {
 alert("동남아 수를 입력해주세요");
 document.form.txtSouthEast.focus();
 return false;
}
if (document.form.txtEtc.value=="") {
 alert("기타를 입력해주세요");
 document.form.txtEtc.focus();
 return false;
}
if(confirm("전송하시겠습니까?")) 
   return true;
  else	
   return false;
}