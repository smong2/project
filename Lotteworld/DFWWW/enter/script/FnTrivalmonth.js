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
 alert("�� ������ �ʼ��Դϴ�.");
 return false;
 }
if (document.form.sltInput_month.value=="") {    
 alert("�� ������ �ʼ��Դϴ�.");
 return false;
 }
if (document.form.txtIndivadultever.value=="") {    
 alert("�������� ����-����� ä���ּ���");
 document.form.txtIndivadultever.focus();
 return false;
 }
if (document.form.txtIndivschoolever.value=="") {
 alert("�������� ����-�߰������ ä���ּ���");
 document.form.txtIndivschoolever.focus();
 return false;
 }
if (document.form.txtIndivchildever.value=="") {
 alert("�������� ����-��̶��� ä���ּ���");
 document.form.txtIndivchildever.focus();
 return false;
 } 
if (document.form.txtGroupadultever.value=="") {
 alert("�������� ��ü-����� ä���ּ���");
 document.form.txtGroupadultever.focus();
 return false;
 } 
if (document.form.txtGroupschoolever.value=="") {
 alert("�������� ��ü-�߰������ ä���ּ���");
 document.form.txtGroupschoolever.focus();
 return false;
 } 
if (document.form.txtGroupchildever.value=="") {
 alert("�������� ��ü-��̶��� ä���ּ���");
 document.form.txtGroupchildever.focus();
 return false;
 } 
if (document.form.txtIndivadultseoul.value=="") {
 alert("���﷣�� ����-����� ä���ּ���");
 document.form.txtIndivadultseoul.focus();
 return false;
 }
if (document.form.txtIndivschoolseoul.value=="") {
 alert("���﷣�� ����-�߰������ ä���ּ���");
 document.form.txtIndivschoolseoul.focus();
 return false;
 }
if (document.form.txtIndivchildseoul.value=="") {
 alert("���﷣�� ����-��̶��� ä���ּ���");
 document.form.txtIndivchildseoul.focus();
 return false;
 } 
if (document.form.txtGroupadultseoul.value=="") {
 alert("���﷣�� ��ü-����� ä���ּ���");
 document.form.txtGroupadultseoul.focus();
 return false;
 } 
if (document.form.txtGroupschoolseoul.value=="") {
 alert("���﷣�� ��ü-�߰������ ä���ּ���");
 document.form.txtGroupschoolseoul.focus();
 return false;
 } 
if (document.form.txtGroupchildseoul.value=="") {
 alert("���﷣�� ��ü-��̶��� ä���ּ���");
 document.form.txtGroupchildseoul.focus();
 return false;
 }  
if(confirm("�����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}
