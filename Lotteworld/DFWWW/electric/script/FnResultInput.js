function FnDate() {
var Year=document.form.sltInput_Year.options[form.sltInput_Year.selectedIndex].value;
var Month=document.form.sltInput_Month.options[form.sltInput_Month.selectedIndex].value;
var Day=document.form.sltInput_Day.options[form.sltInput_Day.selectedIndex].value;
var varmode=document.form.sltMode.value;
var locate='admin_results_input.asp?varview=ok&sltYear=' + Year + '&sltMonth=' + Month + '&sltDay=' + Day + '&sltMode=' + varmode
location=locate;
}
function fncheck() {
if (document.form.sltInput_Year.value=="") {
 alert("���� �������ֽʽÿ�");
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
if (document.form.txtMagicisland.value=="") {
 if(confirm("�������Ϸ��尡 �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}
if (document.form.txtAdventure.value=="") {
 if(confirm("��庥ó�� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}
if (document.form.txtSports.value=="") {
 if(confirm("�������� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}
if (document.form.txtHotel.value=="") {
 if(confirm("ȣ���� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}
if (document.form.txtDepartmentstore.value=="") {
 if(confirm("��ȭ���� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}
if (document.form.txtShoppingmall.value=="") {
 if(confirm("���θ����Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}
if (document.form.txtMart.value=="") {
 if(confirm("��Ʈ�� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}
if (document.form.txtTotal.value=="") {
 if(confirm("�հ谡 �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}
if(confirm("�����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}