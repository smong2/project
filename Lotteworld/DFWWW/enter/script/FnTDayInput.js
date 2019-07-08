function Fn_check() {
if(document.form.sltInput_Year.value==""){
alert("년 선택은 필수입니다");
return false;
}
if(document.form.sltInput_Month.value==""){
alert("월 선택은 필수입니다");
return false;
}
if(document.form.sltInput_Day.value==""){
alert("일 선택은 필수입니다");
return false;
}
if(document.form.txttotal_a.value==""){
alert("전체-어른을 입력해주십시오");
document.form.txttotal_a.focus();
return false;
}
if(document.form.txttotal_s.value==""){
alert("전체-중고생을 입력해주십시오");
document.form.txttotal_s.focus();
return false;
}
if(document.form.txttotal_c.value==""){
alert("전체-어린이를 입력해주십시오");
document.form.txttotal_c.focus();
return false;
}
if(document.form.txtIndiv_a.value==""){
alert("개인-어른을 입력해주십시오");
document.form.txtIndiv_a.focus();
return false;
}
if(document.form.txtIndiv_s.value==""){
alert("개인-중고생을 입력해주십시오");
document.form.txtIndiv_s.focus();
return false;
}
if(document.form.txtIndiv_c.value==""){
alert("개인-어린이를 입력해주십시오");
document.form.txtIndiv_c.focus();
return false;
}
if(document.form.txtGroup_a.value==""){
alert("단체-어른을 입력해주십시오");
document.form.txtGroup_a.focus();
return false;
}
if(document.form.txtGroup_s.value==""){
alert("단체-중고생을 입력해주십시오");
document.form.txtGroup_s.focus();
return false;
}
if(document.form.txtGroup_c.value==""){
alert("단체-어린이를 입력해주십시오");
document.form.txtGroup_c.focus();
return false;
}
if(document.form.txtSpecial_a.value==""){
alert("특판-어른을 입력해주십시오");
document.form.txtSpecial_a.focus();
return false;
}
if(document.form.txtSpecial_s.value==""){
alert("특판-중고생을 입력해주십시오");
document.form.txtSpecial_s.focus();
return false;
}
if(document.form.txtSpecial_c.value==""){
alert("특판-어린이를 입력해주십시오");
document.form.txtSpecial_c.focus();
return false;
}
if(document.form.txtFree_a.value==""){
alert("초대권-어른을 입력해주십시오");
document.form.txtFree_a.focus();
return false;
}
if(document.form.txtFree_s.value==""){
alert("초대권-중고생을 입력해주십시오");
document.form.txtFree_s.focus();
return false;
}
if(document.form.txtFree_c.value==""){
alert("초대권-어린이를 입력해주십시오");
document.form.txtFree_c.focus();
return false;
}
if(document.form.txtEducinst_a.value==""){
alert("학원연합회-어른을 입력해주십시오");
document.form.txtEducinst_a.focus();
return false;
}
if(document.form.txtEducinst_s.value==""){
alert("학원연합회-중고생을 입력해주십시오");
document.form.txtEducinst_s.focus();
return false;
}
if(document.form.txtEducinst_c.value==""){
alert("학원연합회-어린이를 입력해주십시오");
document.form.txtEducinst_c.focus();
return false;
}
if(document.form.txtDutyfree_a.value==""){
alert("면세점-어른을 입력해주십시오");
document.form.txtDutyfree_a.focus();
return false;
}
if(document.form.txtDutyfree_s.value==""){
alert("면세점-중고생을 입력해주십시오");
document.form.txtDutyfree_s.focus();
return false;
}
if(document.form.txtDutyfree_c.value==""){
alert("면세점-어린이를 입력해주십시오");
document.form.txtDutyfree_c.focus();
return false;
}
if(document.form.txtCompany_a.value==""){
alert("기업체특판-어른을 입력해주십시오");
document.form.txtCompany_a.focus();
return false;
}
if(document.form.txtCompany_s.value==""){
alert("기업체특판-중고생을 입력해주십시오");
document.form.txtCompany_s.focus();
return false;
}
if(document.form.txtCompany_c.value==""){
alert("기업체특판-어린이를 입력해주십시오");
document.form.txtCompany_c.focus();
return false;
}
if(document.form.txtMycustomer_a.value==""){
alert("나의손님모시기-어른을 입력해주십시오");
document.form.txtMycustomer_a.focus();
return false;
}
if(document.form.txtMycustomer_s.value==""){
alert("나의손님모시기-중고생을 입력해주십시오");
document.form.txtMycustomer_s.focus();
return false;
}
if(document.form.txtMycustomer_c.value==""){
alert("나의손님모시기-어린이를 입력해주십시오");
document.form.txtMycustomer_c.focus();
return false;
}
if(document.form.txtEtc_a.value==""){
alert("기타-어른을 입력해주십시오");
document.form.txtEtc_a.focus();
return false;
}
if(document.form.txtEtc_s.value==""){
alert("기타-중고생을 입력해주십시오");
document.form.txtEtc_s.focus();
return false;
}
if(document.form.txtEtc_c.value==""){
alert("기타-어린이를 입력해주십시오");
document.form.txtEtc_c.focus();
return false;
}
if(document.form.txttotal_d.value==""){
alert("전체-실입장을 입력해주십시오");
document.form.txttotal_d.focus();
return false;
}
if(document.form.txttotal_d.value==""){
alert("실입장 전체를 입력해주십시오");
document.form.txttotal_d.focus();
return false;
}
if(confirm("전송하시겠습니까?")) 
   return true;
  else	
   return false;
}

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
var Year=document.form.sltInput_Year.options[form.sltInput_Year.selectedIndex].value;
var Month=document.form.sltInput_Month.options[form.sltInput_Month.selectedIndex].value;
var Day=document.form.sltInput_Day.options[form.sltInput_Day.selectedIndex].value;
var locate='admin_results_enter_dayinput.asp?varview=ok&sltYear=' + Year + '&sltMonth=' + Month + '&sltDay=' + Day
location=locate;
}