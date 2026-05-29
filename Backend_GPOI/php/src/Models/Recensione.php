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

    public function findByFilm(int $id_film): array
    {
        $stmt = $this->db->prepare("
            SELECT r.*, a.nome_utente 
            FROM recensione r
            JOIN account a ON r.id_account = a.id_account
            WHERE r.id_film = ?
            ORDER BY r.created_at DESC
        ");
        $stmt->bind_param("i", $id_film);
        $stmt->execute();
        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function findByAccount(int $id_account): array
    {
        $stmt = $this->db->prepare("
            SELECT r.*, f.titolo AS film_titolo
            FROM recensione r
            JOIN film f ON r.id_film = f.id_film
            WHERE r.id_account = ?
            ORDER BY r.created_at DESC
        ");
        $stmt->bind_param("i", $id_account);
        $stmt->execute();
        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function create(int $id_account, int $id_film, string $descrizione, int $valutazione): bool
    {
        $stmt = $this->db->prepare(
            "INSERT INTO recensione (id_account, id_film, descrizione, valutazione) VALUES (?, ?, ?, ?)"
        );
        $stmt->bind_param("iisi", $id_account, $id_film, $descrizione, $valutazione);
        return $stmt->execute();
    }

    public function delete(int $id_recensione): bool
    {
        $stmt = $this->db->prepare("DELETE FROM recensione WHERE id_recensione = ?");
        $stmt->bind_param("i", $id);
        return $stmt->execute();
    }
}