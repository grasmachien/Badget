<?php

$itemsDAO = new itemsDAO();



$app->get('/items/:user_id/?', function($user_id) use ($itemsDAO){
    header("Content-Type: application/json");
    echo json_encode($itemsDAO->selectByUserId($user_id), JSON_NUMERIC_CHECK);
    exit();
});


//GET -> /tweets/:id
$app->get('/items/detail/:id/?', function($id) use ($itemsDAO){
    header("Content-Type: application/json");
    echo json_encode($itemsDAO->selectById($id), JSON_NUMERIC_CHECK);
    exit();
});


//POST -> /tweets/
$app->post('/items/?', function() use ($app, $itemsDAO){
    header("Content-Type: application/json");
    $post = $app->request->post();
    if(empty($post)){
        $post = (array) json_decode($app->request()->getBody());
    }
    echo json_encode($itemsDAO->insert($post), JSON_NUMERIC_CHECK);
    exit();
});

//DELETE -> /tweets/:id
$app->delete('/items/:id/?', function($id) use ($itemsDAO){
    header("Content-Type: application/json");
    echo json_encode($itemsDAO->delete($id));
    exit();
});
//PUT -> /tweets/:id

$app->put('/items/:id/?', function($id) use ($app, $itemsDAO){
    header("Content-Type: application/json");
    $post = $app->request->post();
    if(empty($post)){
        $post = (array) json_decode($app->request()->getBody());
    }
    echo json_encode($itemsDAO->update($id, $post), JSON_NUMERIC_CHECK);
    exit();
});


//GET -> /tweets/tags/:tag => alle tweets met een specifieke hashtag ophalen


$app->get('/items/tags/:tag/?', function($tag) use ($itemsDAO){
    header("Content-Type: application/json");
    echo json_encode($itemsDAO->selectByTag($tag));
    exit();
});



