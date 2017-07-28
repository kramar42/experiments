<?php
require_once('lib/request.php');
require_once('view/json.php');

$request = new Request();

# view can be json or html
$view = new View();

# this file is like main controller
$controller_name = 'controller/' . strtolower($request->url[1]) . '.php';
if (file_exists($controller_name)) {
	require_once($controller_name);

	$controller = new Controller();
	$result = $controller->action($request);

	echo $view->render($result, 200);
} else {
	echo $view->render(null, 404);
}
