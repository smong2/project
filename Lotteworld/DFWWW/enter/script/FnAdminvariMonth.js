function FnDate() {
var Year=document.form.sltYear.options[form.sltYear.selectedIndex].value;
var Month=document.form.sltMonth.options[form.sltMonth.selectedIndex].value;
var locate='admin_vari_Monthinput.asp?varview=ok&sltYear=' + Year + '&sltMonth=' + Month
location=locate;
}
function Fncheck(form) {
if (document.form.sltYear.value=="") {
   alert("�⵵ ������ �ʼ��Դϴ�");
   return false;
 }
if (document.form.sltMonth.value=="") {
   alert("�� ������ �ʼ��Դϴ�");
   return false;
 }
if (document.form.sltGiantRoof.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }
if (document.form.sltGyroDrop.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }
if (document.form.sltGyroSwing.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }
if (document.form.sltIMF.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }
if (document.form.sltCard.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }
if (document.form.txtRepairIndex.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }
if (document.form.txtHosts.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }
if (document.form.txtSnowfall.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }    
if (document.form.txtDepartment.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }
if (document.form.txtKOSPI.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }   
if (document.form.txtManufacturing.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }
if (document.form.txtFinancial.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }      
if (document.form.txtDistribution.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }
if (document.form.txtConstruction.value=="") {
 if(confirm("��� �׸��� �� �Էµ��� �ʾҽ��ϴ�. �׷��� �����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
   }
if(confirm("�����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}