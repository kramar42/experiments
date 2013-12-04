function habratings_update(comments, config) {
	comments.each(function() {
		$(this).attr("hidden", config.filtered);
	});
	chrome.storage.local.set({config:config});
}

function habratings_filter(comments, config) {
	return comments.filter(function() {
		var text = $(this).find(".score").text().replace("–", "-");
		return ((config.max !== undefined && text > config.max) ||
			(config.min !== undefined && text < config.min));
	});
}

function habratings_action() {
	var config = {},
		comments = $(".comment_body");

	chrome.storage.local.get("config", function(data) {
		if (!(config = data.config) ||
			!config.filtered) {
			comments = habratings_filter(comments, config);
		}

		config.filtered = !config.filtered;
		habratings_update(comments, config);
	});
}

chrome.extension.sendRequest({}, function(response) {});