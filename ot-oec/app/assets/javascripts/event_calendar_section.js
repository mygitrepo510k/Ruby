$("#event_calendar").fullCalendar({
	editable: false,
	header:{
		left:'prev,next today',
		center: 'title',
		right: 'month, agendaWeek, agendaDay'
	},
	selectHelper: true,
	defaultView: 'agendaWeek',
	height: 500,
	slotMinutes: 15,
	loading: function(bool){
		if(bool)
			$('#loading').show();
		else
			$('#loading').hide();
	},
	events:'/get_events',
	eventRender:function(event, element){		
		if(event.type == 'experience')
			element.addClass('fc-experience');
		else
			element.tooltipster({content: event.tip});
	},
	eventClick:function(event, element){
		if(event.type == 'experience')
			window.location.href = event.show_link;
	},
	timeFormat: 'h:mm t{ -h:mm t} '
})