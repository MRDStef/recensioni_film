<?php

namespace App\Models;

use PDO;

class RecensioneModel {
    private PDO $db;

    public function __construct(PDO $db) {
        $this->db = $db;
    }

    public function getAll(): array {
        $stmt = $this->db->query('
            SELECT r.*, a.nome_utente, f.titolo AS titolo_film
            FROM Recensione r
            JOIN Account a ON r.id_account = a.id_account
            JOIN Film f    ON r.id_film    = f.id_film
            ORDER BY r.created_at DESC
        ');
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getById(int $id): array|false {
        $stmt = $this->db->prepare('
            SELECT * FROM Recensione WHERE id_recensione = ?
        ');
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getByFilm(int $id_film): array {
        $stmt = $this->db->prepare('
            SELECT r.*, a.nome_utente
            FROM Recensione r
            JOIN Account a ON r.id_account = a.id_account
            WHERE r.id_film = ?
            ORDER BY r.created_at DESC
        ');
        $stmt->execute([$id_film]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getByAccount(int $id_account): array {
        $stmt = $this->db->prepare('
            SELECT r.*, f.titolo AS titolo_film
            FROM Recensione r
            JOIN Film f ON r.id_film = f.id_film
            WHERE r.id_account = ?
            ORDER BY r.created_at DESC
        ');
        $stmt->execute([$id_account]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function add(int $id_film, int $id_account, int $valutazione, string $descrizione): int {
        $stmt = $this->db->prepare('
            INSERT INTO Recensione (id_film, id_account, valutazione, descrizione)
            VALUES (?, ?, ?, ?)
        ');
        $stmt->execute([$id_film, $id_account, $valutazione, $descrizione]);
        return (int)$this->db->lastInsertId();
    }

    public function delete(int $id): void {
        $stmt = $this->db->prepare('DELETE FROM Recensione WHERE id_recensione = ?');
        $stmt->execute([$id]);
    }
}