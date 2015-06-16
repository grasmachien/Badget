<?php

$itemsDAO = new itemsDAO();


$app->get('/data/balanstop/?', function() use ($itemsDAO){
    header("Content-Type: application/json");
    echo json_encode($itemsDAO->getWinnersBalans(), JSON_NUMERIC_CHECK);
    exit();
});

$app->get('/data/lopentop/?', function() use ($itemsDAO){
    header("Content-Type: application/json");
    echo json_encode($itemsDAO->getWinnersLopen(), JSON_NUMERIC_CHECK);
    exit();
});

$app->get('/data/totalbier/?', function() use ($itemsDAO){
    header("Content-Type: application/json");
    echo json_encode($itemsDAO->selectTotalBier(), JSON_NUMERIC_CHECK);
    exit();
});

$app->get('/data/selectTotalPunten/?', function() use ($itemsDAO){
    header("Content-Type: application/json");
    echo json_encode($itemsDAO->selectTotalPunten(), JSON_NUMERIC_CHECK);
    exit();
});

$app->get('/data/selectTotalPhotos/?', function() use ($itemsDAO){
    header("Content-Type: application/json");
    echo json_encode($itemsDAO->selectTotalPhotos(), JSON_NUMERIC_CHECK);
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




