$(function(){
	var content = $("#combined_tweet").text().trim();
	var tm = $("#tweet_message");
	tm.attr("maxlength",(140-content.length));
	$("#launch_tweet_modal_button").click(function(){
		$('#send-tweet-modal').modal("show");
		return false;
	});
	if($("#show_modal").text().trim() == "true") {
		$('#send-tweet-modal').modal("show");
	}
	tm.keypress(function(){
		var new_text = $(this).val();
		var combined = new_text+" "+content;
		$("#combined_tweet").text(combined);
	});
	$("#schedule_tweet_button").click(function(){
		tm.val($("#combined_tweet").text().trim());
	});
});