<?php

$itemsDAO = new itemsDAO();


$app->get('/data/balanstop/?', function() use ($itemsDAO){
    header("Content-Type: application/json");
    echo json_encode($itemsDAO->getWinnersBalans(), JSON_NUMERIC_CHECK);
    exit();
});


//POST -> /tweets/
$app->post('/data/?', function() use ($app, $itemsDAO){
    header("Content-Type: application/json");
    $post = $app->request->post();
    if(empty($post)){
        $post = (array) json_decode($app->request()->getBody());
    }
    echo json_encode($itemsDAO->insertData($post), JSON_NUMERIC_CHECK);
    exit();
});




