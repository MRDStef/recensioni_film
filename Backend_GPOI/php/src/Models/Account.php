<?php

namespace RecensioniFilm\Models;

use RecensioniFilm\Config\Database;

class Account
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    public function findByEmail(string $email): ?array
    {
        $stmt = $this->db->prepare("SELECT * FROM account WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result()->fetch_assoc();
        return $result ?: null;
    }

    public function create(string $username, string $email, string $passwordHash): bool
    {
        $stmt = $this->db->prepare(
            "INSERT INTO account (username, email, password_hash) VALUES (?, ?, ?)"
        );
        $stmt->bind_param("sss", $username, $email, $passwordHash);
        return $stmt->execute();
    }

    public function findById(int $id): ?array
    {
        $stmt = $this->db->prepare("SELECT id, username, email, ruolo, created_at FROM account WHERE id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result()->fetch_assoc();
        return $result ?: null;
    }

    public function updatePassword(int $id, string $passwordHash): bool
    {
        $stmt = $this->db->prepare("UPDATE account SET password_hash = ? WHERE id = ?");
        $stmt->bind_param("si", $passwordHash, $id);
        return $stmt->execute();
    }
}