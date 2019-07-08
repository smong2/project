<!--
function FnCheck() {
if (document.form.txtName.value=="") {
 alert('정상적으로 접속한 페이지가 아닙니다. 로그인 화면으로 이동합니다');
 location.href('../../enter/index.asp');
 return false;
}
if (document.form.txtPWD.value=="") {
 alert('비밀번호를 입력해주십시오');
 document.form.txtPWD.focus();
 return false;
 }
if (document.form.txtDEPT.value=="") {
 alert('부서를 입력해주십시오');
 document.form.txtDEPT.focus();
 return false;
 }
if (document.form.txtTel.value=="") {
 alert('전화번호를 입력해주십시오');
 document.form.txtTel.focus();
 return false;
 }
if(confirm("전송하시겠습니까?")) 
  return true;
 else	
  return false;
}
-->