function fncheck() {
if (document.form.sltInput_Year.value=="") {
alert("년도를 선택해주십시오");
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
if (document.form.txtSpecial.value=="") {
alert("특판을 입력해주십시오");
document.form.txtSpecial.focus();
return false;
}
if (document.form.txtFree.value=="") {
alert("무료초대권을 입력해주십시오");
document.form.txtFree.focus();
return false;
}
if (document.form.txtEducinst.value=="") {
alert("학원연합회를 입력해주십시오");
document.form.txtEducinst.focus();
return false;
}
if (document.form.txtDutyfree.value=="") {
alert("면세점을 입력해주십시오");
document.form.txtDutyfree.focus();
return false;
}
if (document.form.txtCompany.value=="") {
alert("기업체특판을 입력해주십시오");
document.form.txtCompany.focus();
return false;
}
if (document.form.txtMycustomer.value=="") {
alert("나의손님모시기를 입력해주십시오");
document.form.txtMycustomer.focus();
return false;
}
if (document.form.txtEtc.value=="") {
alert("기타를 입력해주십시오");
document.form.txtEtc.focus();
return false;
}
if(confirm("전송하시겠습니까?")) 
   return true;
  else	
   return false;
}