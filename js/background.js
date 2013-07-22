chrome.pageAction.onClicked.addListener(function() {
	chrome.tabs.executeScript(null, {code: "habratings_action()"});
});
chrome.tabs.onActivated.addListener(function() {
	chrome.storage.local.get("config", function(data) {
		data.config.filtered = false;
		chrome.storage.local.set(data);
	});
});

function onRequest(request, sender, sendResponse) {
  chrome.pageAction.show(sender.tab.id);
  sendResponse({});
};
chrome.extension.onRequest.addListener(onRequest);