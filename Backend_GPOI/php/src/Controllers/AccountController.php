<?php

namespace App\Controllers;

use App\Models\AccountModel;
use App\Models\RecensioneModel;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Helpers\JwtHelper;

class AccountController
{
    private AccountModel $accountModel;
    private RecensioneModel $recensioneModel;

    public function __construct(AccountModel $accountModel, RecensioneModel $recensioneModel)
    {
        $this->accountModel = $accountModel;
        $this->recensioneModel = $recensioneModel;
    }

    // get account
    public function getProfile(Request $request, Response $response): Response
    {
        $payload = JwtHelper::getFromRequest($request);

        if (!$payload) {
            $response->getBody()->write(json_encode(['error' => 'Non autenticato']));
            return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
        }

        $account = $this->accountModel->getById($payload->id_account);
        $recensioni = $this->recensioneModel->getByAccount($payload->id_account);

        $response->getBody()->write(json_encode([
            'account' => $account,
            'recensioni' => $recensioni
        ]));
        return $response->withHeader('Content-Type', 'application/json');
    }

    // update password
    public function updatePassword(Request $request, Response $response): Response
    {
        $payload = JwtHelper::getFromRequest($request);

        if (!$payload) {
            $response->getBody()->write(json_encode(['error' => 'Non autenticato']));
            return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
        }

        $data = $request->getParsedBody();
        $nuova = $data['nuova_password'] ?? '';
        $conferma = $data['conferma_password'] ?? '';

        if (!$nuova || $nuova !== $conferma) {
            $response->getBody()->write(json_encode(['error' => 'Le password non coincidono']));
            return $response->withStatus(400)->withHeader('Content-Type', 'application/json');
        }

        $hash = password_hash($nuova, PASSWORD_BCRYPT);
        $this->accountModel->updatePassword($payload->id_account, $hash);

        $response->getBody()->write(json_encode(['message' => 'Password aggiornata']));
        return $response->withHeader('Content-Type', 'application/json');
    }

    // update avatar
    public function updateAvatar(Request $request, Response $response): Response
    {
        $payload = JwtHelper::getFromRequest($request);

        if (!$payload) {
            $response->getBody()->write(json_encode(['error' => 'Non autenticato']));
            return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
        }

        $uploadedFiles = $request->getUploadedFiles();
        $avatar = $uploadedFiles['avatar'] ?? null;

        if (!$avatar || $avatar->getError() !== UPLOAD_ERR_OK) {
            $response->getBody()->write(json_encode(['error' => 'File non valido']));
            return $response->withStatus(400)->withHeader('Content-Type', 'application/json');
        }

        $ext = strtolower(pathinfo($avatar->getClientFilename(), PATHINFO_EXTENSION));
        $allowed = ['jpg', 'jpeg', 'png', 'webp'];

        if (!in_array($ext, $allowed)) {
            $response->getBody()->write(json_encode(['error' => 'Estensione non permessa']));
            return $response->withStatus(400)->withHeader('Content-Type', 'application/json');
        }

        if ($avatar->getSize() > 2 * 1024 * 1024) {
            $response->getBody()->write(json_encode(['error' => 'File troppo grande (max 2MB)']));
            return $response->withStatus(400)->withHeader('Content-Type', 'application/json');
        }

        $filename = uniqid('avatar_', true) . '.' . $ext;
        $uploadDir = __DIR__ . '/../../public/uploads/avatars/';

        if (!is_dir($uploadDir))
            mkdir($uploadDir, 0755, true);

        $avatar->moveTo($uploadDir . $filename);
        $avatar_path = 'uploads/avatars/' . $filename;

        $this->accountModel->updateAvatar($payload->id_account, $avatar_path);

        $response->getBody()->write(json_encode([
            'message' => 'Avatar aggiornato',
            'avatar_url' => $avatar_path
        ]));
        return $response->withHeader('Content-Type', 'application/json');
    }
}