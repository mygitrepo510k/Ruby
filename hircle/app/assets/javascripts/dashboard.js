function dashboard() {
	$("#jobseeker_search").keyup(function() {
		if ($(this).val().length > 2) {
				
			var name = $(this).val();
			 
			$.ajax({
				type : "GET",
				url : "/get_user_name",
				data : {
					user :name
				},
				success : function(msg) {
					$("#jobseeker_result").remove();
					
					var html = "";
					$.each(msg, function(index, value) {
						html += "<li>"+value.first_name+"</li>";
					});
					
					c = "<ul id='jobseeker_result'>" + html +"</ul>";					
					$("#jobseeker_search").after(c);
					
				}
			});
			
		}
	});
	
		
}
