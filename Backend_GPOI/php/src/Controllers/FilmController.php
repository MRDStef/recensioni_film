<?php

namespace App\Controllers;

use App\Models\FilmModel;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class FilmController {
    private FilmModel $filmModel;

    public function __construct(FilmModel $filmModel) {
        $this->filmModel = $filmModel;
    }

    public function getAll(Request $request, Response $response): Response {
        $film = $this->filmModel->getAll();
        $response->getBody()->write(json_encode($film));
        return $response->withHeader('Content-Type', 'application/json');
    }

    public function getById(Request $request, Response $response, array $args): Response {
        $film = $this->filmModel->getById((int)$args['id']);

        if (!$film) {
            $response->getBody()->write(json_encode(['error' => 'Film non trovato']));
            return $response->withStatus(404)->withHeader('Content-Type', 'application/json');
        }

        $response->getBody()->write(json_encode($film));
        return $response->withHeader('Content-Type', 'application/json');
    }

    // inserimento film
    public function add(Request $request, Response $response): Response {
        $data          = $request->getParsedBody();
        $uploadedFiles = $request->getUploadedFiles();

        $titolo             = trim($data['titolo'] ?? '');
        $genere             = trim($data['genere'] ?? '');
        $regista            = trim($data['regista'] ?? '');
        $data_pubblicazione = trim($data['data_pubblicazione'] ?? '');

        if (!$titolo || !$genere || !$data_pubblicazione) {
            $response->getBody()->write(json_encode(['error' => 'Campi obbligatori mancanti']));
            return $response->withStatus(400)->withHeader('Content-Type', 'application/json');
        }

        $locandina_path = $this->handleUpload($uploadedFiles['locandina'] ?? null, 'locandine');
        if ($locandina_path === false) {
            $response->getBody()->write(json_encode(['error' => 'File non valido o troppo grande']));
            return $response->withStatus(400)->withHeader('Content-Type', 'application/json');
        }

        $id = $this->filmModel->add($titolo, $genere, $regista, $data_pubblicazione, $locandina_path);

        $response->getBody()->write(json_encode(['message' => 'Film aggiunto', 'id' => $id]));
        return $response->withStatus(201)->withHeader('Content-Type', 'application/json');
    }

    // aggiornamento film
    public function update(Request $request, Response $response, array $args): Response {
        $data = $request->getParsedBody();

        $titolo             = trim($data['titolo'] ?? '');
        $genere             = trim($data['genere'] ?? '');
        $regista            = trim($data['regista'] ?? '');
        $data_pubblicazione = trim($data['data_pubblicazione'] ?? '');

        if (!$titolo || !$genere || !$data_pubblicazione) {
            $response->getBody()->write(json_encode(['error' => 'Campi obbligatori mancanti']));
            return $response->withStatus(400)->withHeader('Content-Type', 'application/json');
        }

        $this->filmModel->update((int)$args['id'], $titolo, $genere, $regista, $data_pubblicazione);

        $response->getBody()->write(json_encode(['message' => 'Film aggiornato']));
        return $response->withHeader('Content-Type', 'application/json');
    }

    // eliminazione film
    public function delete(Request $request, Response $response, array $args): Response {
        $film = $this->filmModel->getById((int)$args['id']);

        if (!$film) {
            $response->getBody()->write(json_encode(['error' => 'Film non trovato']));
            return $response->withStatus(404)->withHeader('Content-Type', 'application/json');
        }

        $this->filmModel->delete((int)$args['id']);

        $response->getBody()->write(json_encode(['message' => 'Film eliminato']));
        return $response->withHeader('Content-Type', 'application/json');
    }

    // Metodo privato riutilizzabile per l'upload
    private function handleUpload($file, string $cartella): string|null|false {
        if (!$file || $file->getError() !== UPLOAD_ERR_OK) return null;

        $ext     = strtolower(pathinfo($file->getClientFilename(), PATHINFO_EXTENSION));
        $allowed = ['jpg', 'jpeg', 'png', 'webp'];

        if (!in_array($ext, $allowed))          return false;
        if ($file->getSize() > 2 * 1024 * 1024) return false;

        $filename  = uniqid($cartella . '_', true) . '.' . $ext;
        $uploadDir = __DIR__ . '/../../uploads/' . $cartella . '/';

        if (!is_dir($uploadDir)) mkdir($uploadDir, 0755, true);

        $file->moveTo($uploadDir . $filename);
        return 'uploads/' . $cartella . '/' . $filename;
    }
}