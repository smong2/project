function FnDate() {
var Year=document.form.sltInput_Year.options[form.sltInput_Year.selectedIndex].value;
var Month=document.form.sltInput_Month.options[form.sltInput_Month.selectedIndex].value;
var Day=document.form.sltInput_Day.options[form.sltInput_Day.selectedIndex].value;

for(a=0;a<document.form.rdoClass.length;a++)
if(document.form.rdoClass[a].checked==true) {
var LgSm=document.form.rdoClass[a].value;
}
for(b=0;b<document.form.rdoModel.length;b++)
if(document.form.rdoModel[b].checked==true) {
var Mode=document.form.rdoModel[b].value;
}

var locate='admin_results_ticket_plan.asp?varview=ok&sltInput_Year=' + Year + '&sltInput_Month=' + Month + '&sltInput_Day=' + Day + '&rdomodel=' + Mode + '&rdoclass=' + LgSm
location=locate;
}
function fncheck() {

if (document.form.sltInput_Year.value=="") {
alert("년도를 선택해주십시오");
return false;
}

if (document.form.sltInput_Month.value=="") {
 if(confirm("월이 선택되지 않았습니다.\n년 입력인지 확인해보십시오.\n전송하시겠습니까?"))
  return true;
  else
  return false;
}

if (document.form.sltInput_Day.value=="") {
 if(confirm("일이 선택되지 않았습니다.\n월 입력인지 확인해보십시오.\n전송하시겠습니까?"))
  return true;
  else
  return false;
}
if(confirm("전송하시겠습니까?")) 
   return true;
  else	
   return false;
}