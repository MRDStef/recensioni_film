<?php
use Slim\Factory\AppFactory;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

require __DIR__ . '/vendor/autoload.php';
require __DIR__ . '/controllers/AlunniController.php';

$app = AppFactory::create();

$app->get('/test', function (Request $request, Response $response, array $args) {
    $response->getBody()->write("Test page");
    return $response;
});

// Auth
$app->post('/api/auth/register', [AuthController::class, 'register']);
$app->post('/api/auth/login',    [AuthController::class, 'login']);
$app->post('/api/auth/logout',   [AuthController::class, 'logout']);

// Film
$app->get('/api/film',            [FilmController::class, 'getAll']);
$app->get('/api/film/{id}',       [FilmController::class, 'getById']);
$app->post('/api/film',           [FilmController::class, 'add']);      // admin
$app->put('/api/film/{id}',       [FilmController::class, 'update']);   // admin
$app->delete('/api/film/{id}',    [FilmController::class, 'delete']);   // admin

// Recensioni
$app->get('/api/recensioni',              [RecensioneController::class, 'getAll']);
$app->get('/api/film/{id}/recensioni',    [RecensioneController::class, 'getByFilm']);
$app->post('/api/film/{id}/recensioni',   [RecensioneController::class, 'add']);
$app->delete('/api/recensioni/{id}',      [RecensioneController::class, 'delete']); // admin

// Account
$app->get('/api/account/me',             [AccountController::class, 'getProfile']);
$app->put('/api/account/me',             [AccountController::class, 'updatePassword']);
$app->put('/api/account/me/avatar',      [AccountController::class, 'updateAvatar']);

$app->get('/alunni', "AlunniController:index");

$app->run();
