$(function(){
	$("#launch_tweet_modal_button").click(function(){
		$('#send-tweet-modal').modal("show");
		return false;
	});
	if($("#show_modal").text().trim() == "true") {
		$('#send-tweet-modal').modal("show");
	}
});