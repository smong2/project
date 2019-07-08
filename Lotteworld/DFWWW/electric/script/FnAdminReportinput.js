function FnDate() {
var Year=document.form.sltYear.options[form.sltYear.selectedIndex].value;
var Month=document.form.sltMonth.options[form.sltMonth.selectedIndex].value;
var Day=document.form.sltDay.options[form.sltDay.selectedIndex].value;
var locate='report_day_input_table.asp?varview=ok&sltYear=' + Year + '&sltMonth=' + Month + '&sltDay=' + Day
location=locate;
}