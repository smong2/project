function FnDate() {
var Year=document.form.slt_Year.options[form.slt_Year.selectedIndex].value;
var Month=document.form.slt_Month.options[form.slt_Month.selectedIndex].value;
var locate='admin_results_foreigner.asp?varview=ok&sltYear=' + Year + '&sltMonth=' + Month
location=locate;
}

function Fncheck() {
if (document.form.slt_Year.value=="") {
 alert("�� �Է��� �ʼ��Դϴ�.");
 return false;
}
if (document.form.slt_Month.value=="") {
 alert("�� �Է��� �ʼ��Դϴ�.");
 return false;
}
if (document.form.txtTotal.value=="") {
 alert("�հ踦 �Է����ּ���");
 document.form.txtTotal.focus();
 return false;
}
if (document.form.txtJapan.value=="") {
 alert("�Ϻ��μ��� �Է����ּ���");
 document.form.txtJapan.focus();
 return false;
}
if (document.form.txtTaiwan.value=="") {
 alert("�븸�μ��� �Է����ּ���");
 document.form.txtTaiwan.focus();
 return false;
}
if (document.form.txtSouthEast.value=="") {
 alert("������ ���� �Է����ּ���");
 document.form.txtSouthEast.focus();
 return false;
}
if (document.form.txtEtc.value=="") {
 alert("��Ÿ�� �Է����ּ���");
 document.form.txtEtc.focus();
 return false;
}
if(confirm("�����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}