<?php
require_once('controller.php');
require_once('../model/user_model.php');
require_once('../lib/response.php');

class UserController extends Controller {
    public function parse_request($request) {}

    public function get_action($request) {
        $data = $this->model->get_all();

        if (is_string($data)) {
            return new Response(null, $data);
        } else {
            $this->add_parameters($data);
            return new Response($data);
        }
    }

    public function post_action($request) {
        $name = $request->parameters['name'];
        if (isset($name)) {
            $data = $this->model->create($name);
            $this->add_parameters($data);
            if (is_string($data)) {
                return new Response(null, $data);
            }
        } else {
            return new Response(null, 'Missing required parameter: name');
        }
        return $this->get_action($request);
    }
}

