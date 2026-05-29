<?php

namespace App\Models;

use PDO;

class AccountModel {
    private PDO $db;

    public function __construct(PDO $db) {
        $this->db = $db;
    }

    public function getById(int $id): array|false {
        $stmt = $this->db->prepare('
            SELECT id_account, nome_utente, email, ruolo, avatar_url, created_at
            FROM Account WHERE id_account = ?
        ');
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getByEmail(string $email): array|false {
        $stmt = $this->db->prepare('
            SELECT * FROM Account WHERE email = ?
        ');
        $stmt->execute([$email]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function emailEsiste(string $email): bool {
        $stmt = $this->db->prepare('
            SELECT id_account FROM Account WHERE email = ?
        ');
        $stmt->execute([$email]);
        return (bool)$stmt->fetch();
    }

    public function register(string $nome_utente, string $email, string $password): int {
        $stmt = $this->db->prepare('
            INSERT INTO Account (nome_utente, email, password, ruolo)
            VALUES (?, ?, ?, "utente")
        ');
        $stmt->execute([$nome_utente, $email, $password]);
        return (int)$this->db->lastInsertId();
    }

    public function updatePassword(int $id, string $password): void {
        $stmt = $this->db->prepare('
            UPDATE Account SET password = ? WHERE id_account = ?
        ');
        $stmt->execute([$password, $id]);
    }

    public function updateAvatar(int $id, string $avatar_path): void {
        $stmt = $this->db->prepare('
            UPDATE Account SET avatar_url = ? WHERE id_account = ?
        ');
        $stmt->execute([$avatar_path, $id]);
    }
}