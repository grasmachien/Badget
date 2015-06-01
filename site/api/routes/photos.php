<?php
define('DS', DIRECTORY_SEPARATOR);


require_once WWW_ROOT . 'php-image-resize' . DIRECTORY_SEPARATOR . 'ImageResize.php';

$itemsDAO = new itemsDAO();

$app->post('/photos/?', function() use ($app, $itemsDAO){


		header("Content-Type: application/json");

	   $post = $app->request->post();

	  if(empty($post)){
	  	$post = (array) json_decode($app->request()->getBody());
	  }

	  $parts = explode('.', $_FILES['file']['name']);
	  $ext = $parts[sizeof($parts)-1];
	  $name = uniqid() . '.' .  $ext;
	  $OGtype = ($_FILES["file"]["type"]);
	  
	  $path = $_FILES["file"]["tmp_name"];

	  $size = filesize($path);


	  /* kijken als file uniek is, anders path hergebruiken */

	  $post["hash"] = md5_file($_FILES['file']['tmp_name']);
	  $existing = $itemsDAO->selectByHash($post["hash"]);

	  if(!empty($existing)){
	      $post["path"] = $existing["path"];
	  }else{

	  	if($OGtype == "image/jpeg" || $OGtype == "image/png"){
	  		echo json_encode("dit is een afbeelding");
  			$type = "photo";

	 		$post["path"] = 'uploads/'. $name;
	 		$post["pathbig"] = 'uploads/big/'. $name;
	 		$post["type"] = 'photo';
		    $image = new Eventviva\ImageResize($_FILES['file']['tmp_name']);

		    $image->resizeToHeight(500);
	        $image->save(WWW_ROOT . $post['pathbig']);

	        $image->resizeToHeight(300);
	        $image->save(WWW_ROOT . $post['path']);

	  	}else if($OGtype == "video/mp4" && $size <=10000000){
	  		$type = "video";

	  		$post["path"] = 'uploads/'. $name;
	  		$post["pathbig"] = '';
	 		$post["type"] = 'video';

	        $filename = $_FILES["image"]["name"].".mp4";
            $newPath = WWW_ROOT.'uploads'.DS.$name;

            move_uploaded_file($path,$newPath);
	  	}

	      
	  }

	  /* --- */

	  //echo json_encode($itemsDAO->insertimg($post), JSON_NUMERIC_CHECK);

	  exit();


});

