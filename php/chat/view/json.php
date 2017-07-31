<?php

class JsonView {
    public function render($response, $http_code) {
        $result = new stdClass();
        $result->status = $http_code;
        if ($response->has_errors()) {
            $result->errors = $response->get_errors();
        } else {
            $result->result = $response->get_data();
        }
        http_response_code($http_code);
        return json_encode($result, JSON_PRETTY_PRINT);
    }
}
