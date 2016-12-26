	var updateEvent;

$(document).ready(function() {
  return $('#calendar').fullCalendar({
    editable: true,
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    defaultView: 'month',
    height: 500,
    slotMinutes: 30,
    eventSources: [
      {
        url: '/tasks'
      }
    ],
    timeFormat: 'h:mm t{ - h:mm t} ',
    dragOpacity: "0.5",
    eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc) {
      return updateEvent(event);
    },
    eventResize: function(event, dayDelta, minuteDelta, revertFunc) {
      return updateEvent(event);
    }
  });
});

updateEvent = function(the_event) {
  return $.getJSON("/task_update/" + the_event.id, {
    task: {
      title: the_event.title,
      start_date: "" + the_event.start,
      due_date: "" + the_event.end,
      description: the_event.description
    }
  });
};
