<?php
require_once('model/chat.php');

class Controller {
	private $model;
	private $token;
	private $user;

	public function __construct() {
		$this->model = new ChatModel();
	}

	public function action($request) {
		$this->token = $request->parameters['token'];
		if (!isset($this->token)) {
			return null;
		}
		$this->user = $request->parameters['user'];

		switch ($request->action) {
			case 'GET':
				return $this->get_action($request);
				break;
			case 'POST':
				return $this->post_action($request);
				break;
		}
	}

	public function get_action($request) {
		if (isset($this->user)) {
			$data = $this->model->get_conversation($this->token, $this->user);
		} else {
			$data = $this->model->get($this->token);
		}

		if ($data) {
			return $data;
		}
		return null;
	}

	public function post_action($request) {
		$message = $request->parameters['message'];

		if (isset($this->user) && isset($message)) {
			$result = $this->model->send_to($this->token, $this->user, $message);
			if ($result) {
				return $result;
			}
		}
		return null;
	}
}
