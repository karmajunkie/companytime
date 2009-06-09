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
function dateStringFromForm(method){
	allday=$("#leave_period_all_day").attr("checked");
	datestr=$("#"+method).val();
	if(!allday){
		hr=$("#leave_period_"+method+"_4i").val();
		min=$("#leave_period_"+method+"_5i").val();
		datestr+=" "+hr+":"+min+":00";
	}

	return datestr;
}
function dateFromForm(method){
	return new Date(dateStringFromForm(method));
}
function openNewLeavePeriodDlg() {
	$("#leave_period_form_dlg").fadeIn();
}
function addNewLeavePeriod() {
	createFormInputs();
    closeNewLeavePeriodDlg();
}
function createFormInputs(){
	form_inputs=$(".tselect input, .tselect select").clone();
	li=$("<li class='leave_period_item'/>").appendTo("#leave_periods_list");
	form_inputs.each(function(){
		inp=null;
		if($(this).attr("tagName")=="SELECT"){
			//convert to input
			inp=$("<input type='hidden'/>");
			inp.attr("name", $(this).attr('name'));
			inp.attr("id", $(this).attr('id'));
			inp.val($(this).val());
			
		}else{
			inp=$(this)
		}
		inp.attr("name",
			inp.attr('name').replace("leave_period",
					"leave_request[leave_periods_attributes]["+leave_period_count+"]")
		);
		inp.attr("id",
			inp.attr('id').replace("leave_period",
					"leave_request_leave_periods_attributes_"+leave_period_count)
		);

		if(inp.attr("type")!="hidden"){
			inp.css("display", "none");
		}
		inp.appendTo(li);

	});
	leave_period_count++;
	$("<div>From: <strong>"+dateStringFromForm("from_date")+"</strong></div>").appendTo(li);
	$("<div>Until: <strong>"+dateStringFromForm("until_date")+"</strong></div>").appendTo(li);
	return li;

}
function closeNewLeavePeriodDlg() {
	$('#leave_period_form_dlg').fadeOut();
}