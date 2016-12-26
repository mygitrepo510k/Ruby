(function($)
{
	var defaults =
	{
		calId: 0,
		cssName: "default",
		startDate: -1,
		endDate: -1,
		selectedDate: -1,
		showPrevNext: true,
		allowOld: true,
		showAlways: false,
		position: "absolute",
		zIndex:5,
		leftMargin:0,
		topMargin:0,
		showArrow: true,
		inputTarget:false,
		div2Target:false
	};

	var methods =
	{
		init: function(options)
		{
			return this.each(function()
			{
				var self = $(this);
				var settings = $.extend({}, defaults);

				// Save the settings and id
				settings.calId = self[0].id+"-gldp";
				if(options) { settings = $.extend(settings, options); }
				self.data("settings", settings);

				// Bind click and focus event to show
				self
					.click(methods.show)

				// If always showing, trigger click causing it to show
				if(settings.showAlways)
				{
					setTimeout(function() { self.trigger("click"); }, 50);
				}							

				// Bind click elsewhere to hide
				$(document).click(function(e){ 
						methods.hide.apply(self);
				})
				/*$(document).bind("click", function(e)
				{
					//alert(e)
					methods.hide.apply(self);
				});
*/				
				
				var d = new Date();

				var monthNames = ["JAN", "FEB", "MAR", "APR", "MAY", "JUNE", "JULY", "AUG", "SEPT", "OCT", "NOV", "DEC"];
				var monthFullNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];				
				var weekday=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
				
				var month = d.getMonth();				
				var day = d.getDate();
				var cuYear = d.getFullYear();
					cuYear = cuYear.toString().slice(2);									
				var output = ((''+day).length<2 ? '0' : '')+day + ' ' + monthNames[month] + ' ' + cuYear;
				var divDay = ((''+day).length<2 ? '0' : '')+day;
				var divOutput = monthFullNames[month]+' '+d.getFullYear();
				var divWeek = weekday[d.getDay()]
				
				settings.inputTarget==true ? $('.showDate').val(output) : self.val(output);
					
				if(settings.div2Target==true){
					$('#dateView').text(divDay); 
					$('#monthYearView').text(divOutput); 
					$('#weekView').text(divWeek);
				}else{ 
					self.val(output);
				}
				
			});
		},

		// Show the calendar
		show: function(e)
		{
			e.stopPropagation();

			// Instead of catching blur we'll find anything that's made visible
			if($(this).hasClass('_gldp')){
				methods.hide.apply($(this))
			}else{				
				methods.hide.apply($("._gldp").not($(this)));
				methods.update.apply($(this));				
			}
		},

		// Hide the calendar
		hide: function()
		{
			if($(this).length)
			{
				var s = $(this).data("settings");

				// Hide if not showing always
				if(!s.showAlways)
				{
					// Hide the calendar and remove class from target
					$("#"+s.calId).fadeOut(200);
					$(this).removeClass("_gldp");
				}
			}
		},

		// Set a new start date
		setStartDate: function(e)
		{
			$(this).data("settings").startDate = e;
		},

		// Set a new end date
		setEndDate: function(e)
		{
			$(this).data("settings").endDate = e;
		},

		// Set a new selected date
		setSelectedDate: function(e)
		{
			$(this).data("settings").selectedDate = e;
		},
		
		// Set a new Holiday
		setHolidaysDate: function(e)
		{
			//var holiday = holidays;
			$(this).data("settings").holidays = e;
		},

		// Render the calendar
		update:function()
		{
			var target = $(this);
			var settings = target.data("settings");

			// Get the calendar id
			var calId = settings.calId;

			// Get the starting date
			var startDate = settings.startDate;
			if(settings.startDate == -1)
			{
				startDate = new Date();
				startDate.setDate(1);
			}
			startDate.setHours(0,0,0,0);
			var startTime = startDate.getTime();

			// Get the end date
			var endDate = new Date(0);
			if(settings.endDate != -1)
			{
				endDate = new Date(settings.endDate);
				if((/^\d+$/).test(settings.endDate))
				{
					endDate = new Date(startDate);
					endDate.setDate(endDate.getDate()+settings.endDate);
				}
			}
			endDate.setHours(0,0,0,0);
			var endTime = endDate.getTime();

			// Get the selected date
			var selectedDate = new Date(0);
			if(settings.selectedDate != -1)
			{
				selectedDate = new Date(settings.selectedDate);
				if((/^\d+$/).test(settings.selectedDate))
				{
					selectedDate = new Date(startDate);
					selectedDate.setDate(selectedDate.getDate()+settings.selectedDate);
				}
			}
			selectedDate.setHours(0,0,0,0);
			var selectedTime = selectedDate.getTime();
			
			// Get the current date to render
			var theDate = target.data("theDate");
				theDate = (theDate == -1 || typeof theDate == "undefined") ? startDate : theDate;

			// Calculate the first and last date in month being rendered.
			// Also calculate the weekday to start rendering on
			var firstDate = new Date(theDate); firstDate.setDate(1);
			var firstTime = firstDate.getTime();
			var lastDate = new Date(firstDate); lastDate.setMonth(lastDate.getMonth()+1); lastDate.setDate(0);
			var lastTime = lastDate.getTime();
			var lastDay = lastDate.getDate();

			// Calculate the last day in previous month
			var prevDateLastDay = new Date(firstDate);
				prevDateLastDay.setDate(0);
				prevDateLastDay = prevDateLastDay.getDate();

			// The month names to show in toolbar
			var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

			// Save current date
			target.data("theDate", theDate);

			// Render the cells as <TD>
			var days = "";
			for(var y = 0, i = 0; y < 6; y++)
			{
				var row = "";

				for(var x = 0; x < 7; x++, i++)
				{
					var p = ((prevDateLastDay - firstDate.getDay()) + i + 1);
					var n = p - prevDateLastDay;
					var c = (x == 0) ? "sun" : ((x == 6) ? "sat" : "day");

					// If value is outside of bounds its likely previous and next months
					if(n >= 1 && n <= lastDay)
					{
						var today = new Date(); today.setHours(0,0,0,0);
						var date = new Date(theDate); date.setHours(0,0,0,0); date.setDate(n);
						var dateTime = date.getTime();

						// Test to see if it's today
						c = (today.getTime() == dateTime) ? "today":c;

						// Test to see if we allow old dates
						if(!settings.allowOld)
						{
							c = (dateTime < startTime) ? "noday":c;
						}

						// Test against end date
						if(settings.endDate != -1)
						{
							c = (dateTime > endTime) ? "noday":c;
						}

						// Test against selected date
						if(settings.selectedDate != -1)
						{
							c = (dateTime == selectedTime) ? "selected":c;
						}
						
					}
					else
					{
						c = "noday"; // Prev/Next month dates are non-selectable by default
						n = (n <= 0) ? p : ((p - lastDay) - prevDateLastDay);
					}

					// Create the cell
					row += "<td class='gldp-days "+c+" **-"+c+"'><div class='"+c+"'>"+n+"</div></td>";
				}

				// Create the row
				days += "<tr class='days'>"+row+"</tr>";
			}

			// Determine whether to show Previous arrow
			var showP = ((startTime < firstTime) || settings.allowOld);
			var showN = ((lastTime < endTime) || (endTime < startTime));

			// Force override to showPrevNext on false
			if(!settings.showPrevNext) { showP = showN = false; }

			// Build the html for the control
			var titleMonthYear = monthNames[theDate.getMonth()]+" "+theDate.getFullYear();
			var html =
				"<div class='**'>"+
				(settings.showArrow==true ? "<div class='calTopArrow'></div>" : "")
				+"<table cellpadding='0' cellspacing='0'>"+
						"<tr class='calNavigation'>"+ /* Prev Month/Year Next*/
							("<td class='**-prevnext prev'>"+(showP ? "◄":"")+"</td>")+
							"<td class='**-monyear' colspan='5'>{MY}</td>"+
							("<td class='**-prevnext next'>"+(showN ? "►":"")+"</td>")+
						"</tr>"+
						"<tr class='**-dow'>"+ /* Day of Week */
							"<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>"+
						"</tr>"+days+
					"</table>"+
				"</div>";

			// Replace css, month-year title
			html = (html.replace(/\*{2}/gi, "gldp-"+settings.cssName)).replace(/\{MY\}/gi, titleMonthYear);

			// If calendar doesn't exist, make one
			if($("#"+calId).length == 0)
			{
				target.after
				(
					$("<div id='"+calId+"'></div>")
					.css(
					{
						"position":settings.position,
						"z-index":settings.zIndex,
						"margin-left":settings.leftMargin+"px",
						"margin-top":settings.showArrow==true ? target.innerHeight()-10+settings.topMargin : target.innerHeight()+"px"
					})
				);
				$("#"+calId).before("<br class='CL'/>");
			}

			// Show calendar
			var calendar = $("#"+calId);
			calendar.html(html).fadeIn(200);

			// Add a class to make it easier to find when hiding
			target.addClass("_gldp");

			// Handle previous/next clicks
			$("[class*=-prevnext]", calendar).click(function(e)
			{
				e.stopPropagation();

				if($(this).html() != "")
				{
					// Determine offset and set new date
					var offset = $(this).hasClass("prev") ? -1 : 1;
					var newDate = new Date(firstDate);
						newDate.setMonth(theDate.getMonth()+offset);

					// Save the new date and render the change
					target.data("theDate", newDate);
					methods.update.apply(target);
				}
			});

			// Highlight day cell on hover
			$("tr.days td:not(.noday, .selected)", calendar)
				.mouseenter(function(e)
				{
					var css = "gldp-"+settings.cssName+"-"+$(this).children("div").attr("class");
					$(this).removeClass(css).addClass(css+"-hover");
				})
				.mouseleave(function(e)
				{
					if(!$(this).hasClass("selected"))
					{
						var css = "gldp-"+settings.cssName+"-"+$(this).children("div").attr("class");
						$(this).removeClass(css+"-hover").addClass(css);
					}
				})
				.click(function(e)
				{
					e.stopPropagation();
					
					var day = $(this).children("div").html();
					var settings = target.data("settings");
					var newDate = new Date(theDate); newDate.setDate(day);
					
					var d = new Date();
					
					var monthNames = ["JAN", "FEB", "MAR", "APR", "MAY", "JUNE", "JULY", "AUG", "SEPT", "OCT", "NOV", "DEC"];
					
					var monthFullNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];				
					var weekday=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
					
					// Save the new date and update the target control
					
					target.data("theDate", newDate);
					
					var curYear = newDate.getFullYear();
					curYear = curYear.toString().slice(2);
					
					var curMonth = monthNames[(newDate.getMonth())]
					
					settings.inputTarget==true ? $('.showDate').val(((''+newDate.getDate()).length<2 ? '0' : '')+newDate.getDate()+" "+curMonth+" "+curYear) : 		target.val(newDate.getDate()+" "+curMonth+" "+curYear)
					
					var curDay = ((''+newDate.getDate()).length<2 ? '0' : '')+newDate.getDate()
					var curDivOutput = monthFullNames[(newDate.getMonth())]+" "+newDate.getFullYear();
					var curWeek = weekday[newDate.getDay()]
					
					if(settings.div2Target==true){
						$('#dateView').text(curDay); 
						$('#monthYearView').text(curDivOutput); 
						$('#weekView').text(curWeek);
					}else{ 
						target.val(newDate.getDate()+" "+curMonth+" "+curYear)
					}

					// Run callback to user-defined date change method
					if(settings.onChange != null && typeof settings.onChange != "undefined")
					{
						settings.onChange(target, newDate);						
					}
					var css = "gldp-"+settings.cssName
					$('.'+css).find('.'+css+'-selected').removeClass(css+'-selected')
					$(this).addClass(css+'-selected')
					
					// Save selected
					settings.selectedDate = newDate;

					// Hide calendar
					methods.hide.apply(target);
				});
		}
	};

	// Plugin entry
	$.fn.glDatePicker = function(method)
	{
		if(methods[method]) { return methods[method].apply(this, Array.prototype.slice.call(arguments, 1)); }
		else if(typeof method === "object" || !method) { return methods.init.apply(this, arguments); }
		else { $.error("Method "+ method + " does not exist on jQuery.glDatePicker"); }
	};
})(jQuery);