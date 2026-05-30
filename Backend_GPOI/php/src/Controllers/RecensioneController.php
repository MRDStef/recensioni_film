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

    public function getAll(Request $request, Response $response): Response
    {
        $recensioni = $this->recensioneModel->getAll();
        $response->getBody()->write(json_encode($recensioni));
        return $response->withHeader('Content-Type', 'application/json');
    }

    public function getByFilm(Request $request, Response $response, array $args): Response
    {
        $recensioni = $this->recensioneModel->getByFilm((int) $args['id']);
        $response->getBody()->write(json_encode($recensioni));
        return $response->withHeader('Content-Type', 'application/json');
    }

    // inserimento recensione
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

    // eliminazione recensione
    public function delete(Request $request, Response $response, array $args): Response {
        $payload = JwtHelper::getFromRequest($request);

        if (!$payload) {
            $response->getBody()->write(json_encode(['error' => 'Non autenticato']));
            return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
        }

        $recensione = $this->recensioneModel->getById((int)$args['id']);

        if (!$recensione) {
            $response->getBody()->write(json_encode(['error' => 'Recensione non trovata']));
            return $response->withStatus(404)->withHeader('Content-Type', 'application/json');
        }

        // Controlla ruolo
        $isAdmin        = $payload->ruolo === 'admin';
        $isProprietario = $payload->id_account === $recensione['id_account'];

        if (!$isAdmin && !$isProprietario) {
            $response->getBody()->write(json_encode(['error' => 'Non autorizzato']));
            return $response->withStatus(403)->withHeader('Content-Type', 'application/json');
        }

        $this->recensioneModel->delete((int)$args['id']);

        $response->getBody()->write(json_encode(['message' => 'Recensione eliminata']));
        return $response->withHeader('Content-Type', 'application/json');
    }
}