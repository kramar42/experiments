function update_fields() {
	chrome.storage.local.get("config", function(data) {
		if (data.config) {
			min_value = data.config.min;
			max_value = data.config.max;
			filtered = data.config.filtered;

			if (min_value !== undefined) {
				min_field.value = min_value;
			}
			if (max_value !== undefined) {
				max_field.value = max_value;
			}
		}
	});
}

function save_config() {
	chrome.storage.local.set({config: {
		min: min_field.value ? parseInt(min_field.value) : undefined,
		max: max_field.value ? parseInt(max_field.value) : undefined,
		filtered: filtered}});
}

var min_value, max_value, min_field, max_field, filtered;

document.addEventListener("DOMContentLoaded", function() {
	min_field = document.getElementById("min");
	max_field = document.getElementById("max");
	
	update_fields();

	min_field.onkeyup = save_config;
	max_field.onkeyup = save_config;
});