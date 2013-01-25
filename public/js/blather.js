$(function() {
	$("#postbox").focus();
	$("#messages").load("/messages");
	(function poll() {
		$("#messages").load("/messageslp", poll);
	})();
	$('#postform').submit(function(event) {
		event.preventDefault();
		$.post("/messages", {body: $("#postbox").val()}, function(data) {
			console.log(data);
			$("#postbox").val("");
		});
	});
});
