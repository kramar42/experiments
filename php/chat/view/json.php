<?php

class View {
	public function render($result, $http_code) {
		$response = new stdClass();
		$response->status = $http_code;
		if ($result == null) {
			$result = new stdClass();
		}
		$response->result = $result;
		http_response_code($http_code);
		return json_encode($response, JSON_PRETTY_PRINT);
	}
}
