<?php
require_once('model/user.php');

class Controller {
	private $model;

	public function __construct() {
		$this->model = new UserModel();
	}

	public function action($request) {
		# simplifying here - passing only name
		$name = $request->parameters['name'];

		switch ($request->action) {
			case 'GET':
				return $this->get_action($name);
				break;
			case 'POST':
				return $this->post_action($name);
				break;
		}
	}

	public function get_action($name) {
		if (isset($name)) {
			$data = $this->model->get($name);
		} else {
			$data = $this->model->get_all();
		}
		
		if ($data) {
			return $data;
		}
		return null;
	}

	public function post_action($name) {
		if (isset($name)) {
			$result = $this->model->create($name);
			if ($result) {
				return $result;
			}
		}
		return null;
	}
}
