<?php

$usersDAO = new UsersDAO();


//GET -> /users/
$app->get('/users/?',function() use($usersDAO){
	header("Content-Type: application/json");
	echo json_encode($usersDAO->selectAll(), JSON_NUMERIC_CHECK);
	exit();
});
//POST -> /users/
$app->post('/users/?', function() use ($app, $usersDAO){
	header("Content-Type: application/json");
	$post = $app->request->post();
	if(empty($post)){
		$post = (array) json_decode($app->request->getBody());
		$existing = $usersDAO->selectByEmail($post['email']);
	}
	if(empty($existing)){
		echo json_encode($usersDAO->insert($post), JSON_NUMERIC_CHECK);
	}
	exit();
});
// GET -> /user/
$app->get('/users/:email/?', function($email) use ($usersDAO){
    header("Content-Type: application/json");
    echo json_encode($usersDAO->selectByEmail($email), JSON_NUMERIC_CHECK);
    exit();
});