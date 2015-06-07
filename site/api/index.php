<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

define("WWW_ROOT",dirname(dirname(__FILE__)).DIRECTORY_SEPARATOR);

require_once WWW_ROOT. "dao" .DIRECTORY_SEPARATOR. 'ItemsDAO.php';
require_once WWW_ROOT. "dao" .DIRECTORY_SEPARATOR. 'UsersDAO.php';
require_once WWW_ROOT. "api" .DIRECTORY_SEPARATOR. 'Slim'. DIRECTORY_SEPARATOR .'Slim.php';

\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();



require_once WWW_ROOT. "api/routes" .DIRECTORY_SEPARATOR. 'items.php';
require_once WWW_ROOT. "api/routes" .DIRECTORY_SEPARATOR. 'photos.php';
require_once WWW_ROOT. "api/routes" .DIRECTORY_SEPARATOR. 'users.php';





$app->run();

