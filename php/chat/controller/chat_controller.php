<?php
require_once('controller.php');
require_once('../model/chat_model.php');
require_once('../lib/response.php');

class ChatController extends Controller {
    protected $name;
    protected $token;
    protected $user;

    public function parse_request($request) {
        $this->name = $request->parameters['name'];
        if (!isset($this->name)) {
            return new Response(null, 'Missing required parameter: name');
        }
        $this->token = $request->parameters['token'];
        if (!isset($this->token)) {
            return new Response(null, 'Missing required parameter: token');
        }

        if (!$this->model->check_token($this->name, $this->token)) {
            return new Response(null, 'Invalid token or name');
        }
        $this->user = $request->parameters['user'];
    }

    public function get_action($request) {
        if (isset($this->user)) {
            $data = $this->model->get_conversation($this->name, $this->user);
        } else {
            $data = $this->model->get_conversations($this->name);
        }

        if (is_string($data)) {
            return new Response(null, $data);
        } else {
            $this->add_parameters($data);
            return new Response($data);
        }
    }

    public function post_action($request) {
        $message = $request->parameters['message'];

        if (isset($this->user) && isset($message)) {
            $data = $this->model->send_to($this->name, $this->user, $message);
            if (is_string($data)) {
                return new Response(null, $data);
            } else {
                $this->add_parameters($data);
                return new Response($data);
            }
        } else {
            return new Response(null, 'Missing required parameter: message');
        }
    }
}
