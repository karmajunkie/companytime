// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
	$.ajaxSetup({ 
      'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
    });
    $(document).ajaxSend(function(event, request, settings) {
      if ( settings.type.toLowerCase() == 'post' ) {
          settings.data = (settings.data ? settings.data + "&" : "")
              + "authenticity_token=" + encodeURIComponent( AUTH_TOKEN );
      }
    });
});

function approveLeave(request_id){
	sendRequestApproval("approve", request_id);
}
function denyLeave(request_id){
	sendRequestApproval("deny", request_id);
}
function sendRequestApproval(approval,request_id ){
	$.ajax(
  { dataType:'script',
    error:leaveRequestUpdateError,
    url:"/leave_requests/"+approval+"/"+request_id,
    type:"get"
  });
}
function leaveRequestUpdateError(data, textStatus, errorThrown){
	alert(data);
}
