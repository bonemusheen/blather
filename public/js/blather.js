$(function() {
	$("#postbox").focus();
	$("#messages").load("/messages");
	(function poll() {
		$("#messages").load("/messageslp", poll);
	})();
});
