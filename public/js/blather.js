$(function() {
	$("#postbox").focus();
	$("#messages").load("/messages");
	/*setInterval(function() { $("#messages").load("/messages"); console.log("ping"); }, 2000);*/
	(function poll() {
		$("#messages").load("/messageslp", poll);
		console.log("ping");
	})();
});
