<?php

namespace App\Controllers;

use App\Models\RecensioneModel;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Helpers\JwtHelper;

class RecensioneController
{
    private RecensioneModel $recensioneModel;

    public function __construct(RecensioneModel $recensioneModel)
    {
        $this->recensioneModel = $recensioneModel;
    }

    // GET /api/recensioni
    public function getAll(Request $request, Response $response): Response
    {
        $recensioni = $this->recensioneModel->getAll();
        $response->getBody()->write(json_encode($recensioni));
        return $response->withHeader('Content-Type', 'application/json');
    }

    // GET /api/film/{id}/recensioni
    public function getByFilm(Request $request, Response $response, array $args): Response
    {
        $recensioni = $this->recensioneModel->getByFilm((int) $args['id']);
        $response->getBody()->write(json_encode($recensioni));
        return $response->withHeader('Content-Type', 'application/json');
    }

    // POST /api/film/{id}/recensioni  (utente loggato)
    // POST /api/film/{id}/recensioni
    public function add(Request $request, Response $response, array $args): Response
    {
        $payload = JwtHelper::getFromRequest($request);

        if (!$payload) {
            $response->getBody()->write(json_encode(['error' => 'Non autenticato']));
            return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
        }

        $data = $request->getParsedBody();
        $valutazione = (int) ($data['valutazione'] ?? 0);
        $descrizione = trim($data['descrizione'] ?? '');

        if ($valutazione < 1 || $valutazione > 5) {
            $response->getBody()->write(json_encode(['error' => 'Valutazione non valida (1-5)']));
            return $response->withStatus(400)->withHeader('Content-Type', 'application/json');
        }

        $this->recensioneModel->add((int) $args['id'], $payload->id_account, $valutazione, $descrizione);

        $response->getBody()->write(json_encode(['message' => 'Recensione aggiunta']));
        return $response->withStatus(201)->withHeader('Content-Type', 'application/json');
    }

    // DELETE /api/recensioni/{id}  (solo admin)
    public function delete(Request $request, Response $response, array $args): Response
    {
        $this->recensioneModel->delete((int) $args['id']);

        $response->getBody()->write(json_encode(['message' => 'Recensione eliminata']));
        return $response->withHeader('Content-Type', 'application/json');
    }
}