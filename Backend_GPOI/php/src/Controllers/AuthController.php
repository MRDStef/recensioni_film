<?php

namespace App\Controllers;

use App\Models\AccountModel;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Helpers\JwtHelper;

class AuthController
{
    private AccountModel $accountModel;

    public function __construct(AccountModel $accountModel)
    {
        $this->accountModel = $accountModel;
    }

    // Registrazione 
    public function register(Request $request, Response $response): Response
    {
        $data = $request->getParsedBody();

        $nome_utente = trim($data['nome_utente'] ?? '');
        $email = trim($data['email'] ?? '');
        $password = password_hash($data['password'], PASSWORD_BCRYPT);

        // Controllo campi
        if (!$nome_utente || !$email || !$password) {
            $response->getBody()->write(json_encode(['error' => 'Campi mancanti']));
            return $response->withStatus(400)->withHeader('Content-Type', 'application/json');
        }

        // Controllo email duplicata
        if ($this->accountModel->emailEsiste($email)) {
            $response->getBody()->write(json_encode(['error' => 'Email già in uso']));
            return $response->withStatus(409)->withHeader('Content-Type', 'application/json');
        }

        $this->accountModel->register($nome_utente, $email, $password);

        $response->getBody()->write(json_encode(['message' => 'Registrazione avvenuta']));
        return $response->withStatus(201)->withHeader('Content-Type', 'application/json');
    }

    // login 
    public function login(Request $request, Response $response): Response
    {
        $data = $request->getParsedBody();

        $email = trim($data['email'] ?? '');
        $password = $data['password'] ?? '';

        // Controllo campi
        if (!$email || !$password) {
            $response->getBody()->write(json_encode(['error' => 'Campi mancanti']));
            return $response->withStatus(400)->withHeader('Content-Type', 'application/json');
        }

        $account = $this->accountModel->getByEmail($email);

        // Controllo credenziali
        if (!$account || !password_verify($password, $account['password'])) {
            $response->getBody()->write(json_encode(['error' => 'Credenziali errate']));
            return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
        }

        $token = JwtHelper::generate(
            $account['id_account'],
            $account['ruolo'],
            $account['nome_utente']
        );

        $response->getBody()->write(json_encode([
            'message' => 'Login effettuato',
            'token' => $token,
            'nome_utente' => $account['nome_utente'],
            'ruolo' => $account['ruolo']
        ]));
        return $response->withStatus(200)->withHeader('Content-Type', 'application/json');
    }

    // logout
    public function logout(Request $request, Response $response): Response
    {
        // Con JWT il logout è gestito dal client che elimina il token
        $response->getBody()->write(json_encode(['message' => 'Logout effettuato']));
        return $response->withStatus(200)->withHeader('Content-Type', 'application/json');
    }
}