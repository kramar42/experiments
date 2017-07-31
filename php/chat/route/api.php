<?php
require_once('../lib/request.php');
require_once('../view/json.php');

$request = new Request();
$view = new JsonView();

$controller_name = strtolower($request->url[1]);
$controller_path = '../controller/' . $controller_name . '_controller.php';
$model_path = '../model/' . $controller_name . '_model.php';
if (file_exists($controller_path)) {
    require_once($controller_path);

    if (file_exists($model_path)) {
        require_once($model_path);

        $controller_class = ucfirst($controller_name . 'Controller');
        $model_class = ucfirst($controller_name . 'Model');

        $controller = new $controller_class(new $model_class());
        $response = $controller->action($request);

        echo $view->render($response, 200);
    } else {
        echo $view->render(null, 404);
    }
} else {
    echo $view->render(null, 404);
}
