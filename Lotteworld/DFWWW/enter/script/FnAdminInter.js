<!--
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

function FnCheck() {
if(document.form.sltType.value=="") {
alert('�� ������ �������ֽʽÿ�-��,��,��');
return false;
}
if(confirm("�����Ͻðڽ��ϱ�?")) 
  return true;
 else	
  return false;
}
-->