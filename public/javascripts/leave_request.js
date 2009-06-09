$(document).ready(function() {
	Date.format = "mm/dd/yyyy";
	Date.firstDayOfWeek = 0;
	$(".js_calendar").datePicker().val(new Date().asString()).
			trigger("change").
			bind(
			// when a date is selected update the SELECTs
				'dateSelected',
				function(e, selectedDate, $td, state)
				{
					updateInputs($(this).attr("id"), selectedDate);
				}
			);
    $("#leave_period_all_day").bind("change", function(e){
        if(!$(this).attr("checked")){
            $("#leave_period_from_date_4i").attr("disabled", false);
            $("#leave_period_from_date_5i").attr("disabled", false);
            $("#leave_period_from_date_6i").attr("disabled", false);
            $("#leave_period_until_date_4i").attr("disabled", false);
            $("#leave_period_until_date_5i").attr("disabled", false);
            $("#leave_period_until_date_6i").attr("disabled", false);
        }else{
            $("#leave_period_from_date_4i").attr("disabled", true);
            $("#leave_period_from_date_5i").attr("disabled", true);
            $("#leave_period_from_date_6i").attr("disabled", true);
            $("#leave_period_until_date_4i").attr("disabled", true);
            $("#leave_period_until_date_5i").attr("disabled", true);
            $("#leave_period_until_date_6i").attr("disabled", true);
        }
    });
    updateInputs("from_date", new Date());
    updateInputs("until_date", new Date());
});
function updateInputs(type, selectedDate) {

	$("#leave_period_"+type+"_1i").val(selectedDate.getFullYear());
	$("#leave_period_"+type+"_2i").val(selectedDate.getMonth());
	$("#leave_period_"+type+"_3i").val(selectedDate.getDate());
}
function openNewLeavePeriodDlg() {
	$("#leave_period_form_dlg").slideToggle();
}
function addNewLeavePeriod() {
	$('#leave_period_form_dlg').slideUp();
    
}
function closeNewLeavePeriodDlg() {
	$('#leave_period_form_dlg').slideUp();
}