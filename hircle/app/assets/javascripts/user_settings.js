$(document).ready(function() {
	
	dashboard();
	
	$("div.content3:not(:first)").hide();
	$("div.accordion-inner a").click(function(event) {
		event.preventDefault();
		var id = $(this).attr('href').split("#")[1];
		$("div.content3").hide();
		$("div#" + id).show();
	});

	$("input[id^=optionsRadios]").change(function() {
		if ($(this).attr("checked")) {
			var privacy = $(this).attr("value").split('option')[1];
			privacy_ajax(privacy)
		}
	});

	$("button[id^=submit]").click(function() {
		var r_type = $(this).attr("id").split('_')[1];

		if (r_type == 'search') {
			save_search_ajax(r_type)
		} else if (r_type == 'zone') {
			save_zone_ajax(r_type)
		} else if (r_type == 'cancel') {
			cancel_ajax(r_type)
		} 
	});
	
	function password_ajax(current_pass, new_pass, confirm_pass) {
		
		$.ajax({
			type : "GET",
			url : "/submit_password",			
			data : {
				user:{
					current_password : current_pass,
					password : new_pass,
					password_confirmation : confirm_pass	
				}				
			},
			success : function(msg) {
				alert("Password Changed Saved:");
			}
		});
	}

	function save_search_ajax(r_type) {
		city = $("select#search_city option:selected").text();
		state = $("select#search_state option:selected").text();
		zip = $("select#search_zip option:selected").text();

		$.ajax({
			type : "GET",
			url : "/submit_search",
			request_type : r_type,
			data : {
				city : city,
				state : state,
				zip : zip
			},
			success : function(msg) {
				alert("Search Data Saved:");
			}
		});
	}

	function save_zone_ajax(r_type) {
		zone = $("select#search_zone option:selected").text();

		$.ajax({
			type : "GET",
			url : "/submit_zone",
			request_type : r_type,
			data : {
				zone : zone
			},
			success : function(msg) {
				alert("Zone Saved:");
			}
		})
	}

	function privacy_ajax(privacy) {

		$.ajax({
			type : "GET",
			url : "/submit_privacy",
			data : {
				privacy : privacy
			},
			success : function(msg) {
				alert("Privacy Data Saved:");
			}
		})
	}

	function cancel_ajax(r_type) {
		didConfirm = confirm("Are you sure you want to cancel the account?");
		if (didConfirm == true) {
			
			$.ajax({
				type : "GET",
				url : "/cancel_account",
				request_type : r_type,
				data : {
					cancel : true
				},
				success : function(msg) {
					alert("Canceled Account:");
					window.location = "/";
				}
			})
		}
	}

});

// function user_settings()
// {
//
// }
