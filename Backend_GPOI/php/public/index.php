<?php

use Slim\Factory\AppFactory;
use Slim\Routing\RouteCollectorProxy;
use App\Controllers\AuthController;
use App\Controllers\FilmController;
use App\Controllers\RecensioneController;
use App\Controllers\AccountController;
use App\Models\AccountModel;
use App\Models\FilmModel;
use App\Models\RecensioneModel;

require __DIR__ . '/../vendor/autoload.php';

// Carica variabili d'ambiente
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/../');
$dotenv->load();

// Connessione al database
$db = new PDO(
    'mysql:host=' . $_ENV['DB_HOST'] . ';dbname=' . $_ENV['DB_NAME'] . ';charset=utf8',
    $_ENV['DB_USER'],
    $_ENV['DB_PASS']
);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

// Model
$accountModel    = new AccountModel($db);
$filmModel       = new FilmModel($db);
$recensioneModel = new RecensioneModel($db);

// Controller
$authController       = new AuthController($accountModel);
$filmController       = new FilmController($filmModel);
$recensioneController = new RecensioneController($recensioneModel);
$accountController    = new AccountController($accountModel, $recensioneModel);

$app = AppFactory::create();

// Middleware per il parsing del body JSON
$app->addBodyParsingMiddleware();

// Middleware per la gestione degli errori
$app->addErrorMiddleware(true, true, true);

// CORS
$app->add(function ($request, $handler) {
    $response = $handler->handle($request);
    return $response
        ->withHeader('Access-Control-Allow-Origin', 'http://localhost:4200')
        ->withHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization')
        ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
});

// Gestione preflight OPTIONS (richiesta CORS preliminare del browser)
$app->options('/{routes:.+}', function ($request, $response) {
    return $response;
});

// Rotte Auth
$app->group('/api/auth', function (RouteCollectorProxy $group) use ($authController) {
    $group->post('/register', [$authController, 'register']);
    $group->post('/login',    [$authController, 'login']);
    $group->post('/logout',   [$authController, 'logout']);
});

// Rotte Film
$app->group('/api/film', function (RouteCollectorProxy $group) use ($filmController, $recensioneController) {
    $group->get('',        [$filmController, 'getAll']);
    $group->get('/{id}',   [$filmController, 'getById']);
    $group->post('',       [$filmController, 'add']);
    $group->put('/{id}',   [$filmController, 'update']);
    $group->delete('/{id}',[$filmController, 'delete']);

    // Recensioni per film
    $group->get('/{id}/recensioni',  [$recensioneController, 'getByFilm']);
    $group->post('/{id}/recensioni', [$recensioneController, 'add']);
});

// Rotte Recensioni
$app->group('/api/recensioni', function (RouteCollectorProxy $group) use ($recensioneController) {
    $group->get('',        [$recensioneController, 'getAll']);
    $group->delete('/{id}',[$recensioneController, 'delete']);
});

// Rotte Account
$app->group('/api/account', function (RouteCollectorProxy $group) use ($accountController) {
    $group->get('/me',          [$accountController, 'getProfile']);
    $group->put('/me',          [$accountController, 'updatePassword']);
    $group->put('/me/avatar',   [$accountController, 'updateAvatar']);
});

$app->run();