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
});
function updateInputs(type, selectedDate) {
	alert(type);
	$("#"+type+"_time_1i").val(selectedDate.getFullYear());
	$("#"+type+"_time_2i").val(selectedDate.getMonth());
	$("#"+type+"_time_3i").val(selectedDate.getDate());
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