<?php
require_once('../lib/request.php');
require_once('../controller/chat_controller.php');
require_once('../model/chat_model.php');

$request = new Request();
$controller = new ChatController(new ChatModel());
$response = $controller->action($request);

include('../view/chat_view.php');
