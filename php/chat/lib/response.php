<?php
class Response {
    protected $data;
    protected $errors = array();
    protected $code;

    public function __construct($data, $error=null) {
        $this->data = $data;
        if (isset($error)) {
            $this->errors[] = $error;
        }
    }

    public function get_data() {
        return $this->data;
    }

    public function get_errors() {
        return $this->errors;
    }

    public function add_error($error) {
        $this->errors[] = $error;
        return $this->errors;
    }

    public function get_code() {
        return $this->code;
    }

    public function has_errors() {
        return !empty($this->errors);
    }
}
