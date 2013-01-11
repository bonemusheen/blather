$(function() {
	$("#postbox").focus();
	$("#messages").load("/messages");
	setInterval(function() { $("#messages").load("/messages"); console.log("ping"); }, 2000)
});
