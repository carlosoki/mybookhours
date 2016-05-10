<?php

use Symfony\Component\HttpFoundation\Request;

$loader = require_once __DIR__.'/../app/autoload.php';
require_once __DIR__.'/../app/AppKernel.php';

$env = getenv('SYMFONY_ENV');

if ('dev' === $env || 'test' === $env) {
    $debug = true;
} elseif ('prod' === $env) {
    $debug = false;
} else {
    throw new Exception('Please provide an apache environment variable: dev, test or prod');
}

$kernel = new AppKernel($env, $debug);

Request::enableHttpMethodParameterOverride();
$request = Request::createFromGlobals();
$response = $kernel->handle($request);
$response->send();
$kernel->terminate($request, $response);
