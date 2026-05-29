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

    public function create(string $nome_utente, string $email, string $password): bool
    {
        $stmt = $this->db->prepare(
            "INSERT INTO account (nome_utente, email, password) VALUES (?, ?, ?)"
        );
        $stmt->bind_param("sss", $nome_utente, $email, $password);
        return $stmt->execute();
    }

    public function findById(int $id_account): ?array
    {
        $stmt = $this->db->prepare("SELECT * FROM account WHERE id_account = ?");
        $stmt->bind_param("i", $id_account);
        $stmt->execute();
        $result = $stmt->get_result()->fetch_assoc();
        return $result ?: null;
    }

    public function updatePassword(int $id_account, string $password): bool
    {
        $stmt = $this->db->prepare("UPDATE account SET password = ? WHERE id_account = ?");
        $stmt->bind_param("si", $password, $id_account);
        return $stmt->execute();
    }
}