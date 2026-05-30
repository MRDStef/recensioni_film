<?php

namespace App\Helpers;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class JwtHelper {

    private static function getSecret(): string {
        return $_ENV['JWT_SECRET'];
    }

    public static function generate(int $id_account, string $ruolo, string $nome_utente): string {
        $payload = [
            'iat'         => time(),
            'exp'         => time() + (60 * 60 * 8),
            'id_account'  => $id_account,
            'ruolo'       => $ruolo,
            'nome_utente' => $nome_utente
        ];
        return JWT::encode($payload, self::getSecret(), 'HS256');
    }

    public static function decode(string $token): object|false {
        try {
            return JWT::decode($token, new Key(self::getSecret(), 'HS256'));
        } catch (\Exception $e) {
            return false;
        }
    }

    public static function getFromRequest(\Psr\Http\Message\ServerRequestInterface $request): object|false {
        $header = $request->getHeaderLine('Authorization');
        if (!str_starts_with($header, 'Bearer ')) return false;

        $token = substr($header, 7);
        return self::decode($token);
    }
}