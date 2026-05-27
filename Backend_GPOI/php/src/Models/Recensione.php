<?php

namespace RecensioniFilm\Models;

use RecensioniFilm\Config\Database;

class Recensione
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    public function findByFilm(int $filmId): array
    {
        $stmt = $this->db->prepare("
            SELECT r.*, a.username 
            FROM recensione r
            JOIN account a ON r.account_id = a.id
            WHERE r.film_id = ?
            ORDER BY r.created_at DESC
        ");
        $stmt->bind_param("i", $filmId);
        $stmt->execute();
        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function findByAccount(int $accountId): array
    {
        $stmt = $this->db->prepare("
            SELECT r.*, f.titolo AS film_titolo
            FROM recensione r
            JOIN film f ON r.film_id = f.id
            WHERE r.account_id = ?
            ORDER BY r.created_at DESC
        ");
        $stmt->bind_param("i", $accountId);
        $stmt->execute();
        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function create(int $accountId, int $filmId, string $testo, int $rating): bool
    {
        $stmt = $this->db->prepare(
            "INSERT INTO recensione (account_id, film_id, testo, rating) VALUES (?, ?, ?, ?)"
        );
        $stmt->bind_param("iisi", $accountId, $filmId, $testo, $rating);
        return $stmt->execute();
    }

    public function delete(int $id): bool
    {
        $stmt = $this->db->prepare("DELETE FROM recensione WHERE id = ?");
        $stmt->bind_param("i", $id);
        return $stmt->execute();
    }
}