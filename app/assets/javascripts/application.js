// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require ckeditor/init
//= require turbolinks
//= require jquery.turbolinks
//= require_tree .

$(document).ready(function(){
$( ".favorite" ).click(function() {
	var classy =	$("#fav").attr('class');
	var count = parseInt($(".item-favcount").text(), 10);
	
	  var item_id = $(this).attr('id');
	  $.ajax({
	    type: "POST",
	  beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	
	    url: '/favorites/' + item_id,
	  processData : false,
	    success: function() {
		
	      // change image or something
	
		if (classy == "glyphicon glyphicon-heart")
		{
			$("#fav").removeClass( "glyphicon-heart" );

		  $("#fav").addClass( "glyphicon-heart-empty" );

			if(count>0)
			{
				count = count -1;
			}
			else
			{
				count = 0;
			}

			$(".item-favcount").html(count);

		}
		else
		{
			$("#fav").removeClass( "glyphicon-heart-empty" );
			$("#fav").addClass( "glyphicon-heart" );
				 count = count + 1;
				$(".item-favcount").html(count);
		}
	
	    }
	  });
	

	return false;
});



$( ".follow-btn" ).click(function() {
		var classy =	$("#follow").attr('class');
		var followcount = parseInt($(".follow-count").text(), 10);

		  var user_id = $(this).attr('id');
		  $.ajax({
		    type: "POST",
		  beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},

		    url: '/relationships/' + user_id,
		  processData : false,
		    success: function() {

		      // change image or something

			if (classy == "followed")
			{
				$("#follow").removeClass( "followed" );
			  	$("#follow").addClass( "unfollowed" );
					$(".follow-btn").addClass( "btn-success" );
					$(".follow-btn").removeClass( "btn-default" );
						if(followcount>0)
						{
							followcount = followcount -1;
						}
						else
						{
							followcount = 0;
						}

						$(".follow-count").html(followcount);

	$("#follow").html("Follow");

			}
			else
			{
				$("#follow").removeClass( "unfollowed" );
				$("#follow").addClass( "followed" );
				
						$(".follow-btn").removeClass( "btn-success" );
						$(".follow-btn").addClass( "btn-default" );
					
				$("#follow").html("Unfollow");
					 followcount = followcount + 1;
					$(".follow-count").html(followcount);

			}

		    }
		  });


		return false;
});




});