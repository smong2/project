function fncheck() {
if (document.form.sltInput_Year.value=="") {
alert("�⵵�� �������ֽʽÿ�");
return false;
}
if (document.form.sltInput_Month.value=="") {
alert("���� �������ֽʽÿ�");
return false;
}
if (document.form.sltInput_Day.value=="") {
alert("���� �������ֽʽÿ�");
return false;
}
if (document.form.txtSpecial.value=="") {
alert("Ư���� �Է����ֽʽÿ�");
document.form.txtSpecial.focus();
return false;
}
if (document.form.txtFree.value=="") {
alert("�����ʴ���� �Է����ֽʽÿ�");
document.form.txtFree.focus();
return false;
}
if (document.form.txtEducinst.value=="") {
alert("�п�����ȸ�� �Է����ֽʽÿ�");
document.form.txtEducinst.focus();
return false;
}
if (document.form.txtDutyfree.value=="") {
alert("�鼼���� �Է����ֽʽÿ�");
document.form.txtDutyfree.focus();
return false;
}
if (document.form.txtCompany.value=="") {
alert("���üƯ���� �Է����ֽʽÿ�");
document.form.txtCompany.focus();
return false;
}
if (document.form.txtMycustomer.value=="") {
alert("���ǼմԸ�ñ⸦ �Է����ֽʽÿ�");
document.form.txtMycustomer.focus();
return false;
}
if (document.form.txtEtc.value=="") {
alert("��Ÿ�� �Է����ֽʽÿ�");
document.form.txtEtc.focus();
return false;
}
if(confirm("�����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}