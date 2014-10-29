$(function(){
	$(".example a").click(function(){
		$(this).hide();
		$("#example-content").toggle();
		return false;
	});
});