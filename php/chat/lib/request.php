<?php

class Request {
	public $action;
	public $url;
	public $parameters;

	public function __construct() {
		$this->action = $_SERVER['REQUEST_METHOD'];
		$this->url = explode('/', $_SERVER['PATH_INFO']);

		if (isset($_SERVER['QUERY_STRING'])) {
			parse_str($_SERVER['QUERY_STRING'], $this->parameters);
		}
		$this->parameters = array_merge($this->parameters, $_POST);
	}
}
