// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.facebox
//= require parsley
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .


function moveEvent(event, dayDelta, minuteDelta, allDay){
	jQuery.ajax({
		data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&all_day=' + allDay,
		dataType: 'script',
		type: 'post',
		url: "/calendar/move"
	});
}

function resizeEvent(event, dayDelta, minuteDelta){
	jQuery.ajax({
		data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta,
		dataType: 'script',
		type: 'post',
		url: "/calendar/resize"
	});
	}

function showEventDetails(event){
	$('#event_desc').html(event.description);
	$('#edit_event').html("<a href = 'javascript:void(0);' onclick ='editEvent(" + event.id + ")'>Edit</a>");
	if (event.recurring) {
		title = event.title + "(Recurring)";
		$('#delete_event').html("&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete Only This Occurrence</a>");
		$('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + true + ")'>Delete All In Series</a>")
		$('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", \"future\")'>Delete All Future Events</a>")
	}
	else {
		title = event.title;
		$('#delete_event').html("<a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete</a>");
	}
	$('#desc_dialog').dialog({
		title: title,
		modal: true,
		width: 500,
		close: function(event, ui){
			$('#desc_dialog').dialog('destroy')
		}		
	});		
}


function editEvent(event_id){
	jQuery.ajax({
		data: 'id=' + event_id,
		dataType: 'script',
		type: 'get',
		url: "/calendar/edit"
	});
}

function deleteEvent(event_id, delete_all){
	jQuery.ajax({
		data: 'id=' + event_id + '&delete_all='+delete_all,
		dataType: 'script',
		type: 'post',
		url: "/calendar/destroy"
	});
}

function showPeriodAndFrequency(value){
	switch (value) {
		case 'Daily':
			$('#period').html('day');
			$('#frequency').show();
			break;
		case 'Weekly':
			$('#period').html('week');
			$('#frequency').show();
			break;
		case 'Monthly':
			$('#period').html('month');
			$('#frequency').show();
			break;
		case 'Yearly':
			$('#period').html('year');
			$('#frequency').show();
			break;
			
		default:
			$('#frequency').hide();
	}	 
}

