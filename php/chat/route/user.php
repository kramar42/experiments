<?php
require_once('../lib/request.php');
require_once('../controller/user_controller.php');
require_once('../model/user_model.php');

$request = new Request();
$controller = new UserController(new UserModel());
$response = $controller->action($request);

include('../view/user_view.php');
