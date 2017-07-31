<?php
class Controller {
    protected $model;

    public function __construct($model) {
        $this->model = $model;
    }

    public function action($request) {
        $response = $this->parse_request($request);
        if (isset($response)) {
            return $response;
        }

        switch ($request->action) {
            case 'GET':
                return $this->get_action($request);
                break;
            case 'POST':
                return $this->post_action($request);
                break;
        }
    }

    protected function add_parameters($data) {
        foreach (get_object_vars($this) as $key=>$val) {
            $data->$key = $val;
        }
    }
}
