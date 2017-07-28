<?php
require_once('lib/request.php');
require_once('controller/user.php');

$request = new Request();
$controller = new Controller();
$result = $controller->action($request);

include('view/user.html');
