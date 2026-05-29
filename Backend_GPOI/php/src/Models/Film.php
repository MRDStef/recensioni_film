<?php

namespace App\Models;

use PDO;

class FilmModel {
    private PDO $db;

    public function __construct(PDO $db) {
        $this->db = $db;
    }

    public function getAll(): array {
        $stmt = $this->db->query('
            SELECT * FROM Film ORDER BY data_pubblicazione DESC
        ');
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getById(int $id): array|false {
        $stmt = $this->db->prepare('
            SELECT * FROM Film WHERE id_film = ?
        ');
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function add(string $titolo, string $genere, string $regista, string $data, ?string $locandina): int {
        $stmt = $this->db->prepare('
            INSERT INTO Film (titolo, genere, regista, data_pubblicazione, locandina_path)
            VALUES (?, ?, ?, ?, ?)
        ');
        $stmt->execute([$titolo, $genere, $regista, $data, $locandina]);
        return (int)$this->db->lastInsertId();
    }

    public function update(int $id, string $titolo, string $genere, string $regista, string $data): void {
        $stmt = $this->db->prepare('
            UPDATE Film SET titolo=?, genere=?, regista=?, data_pubblicazione=?
            WHERE id_film = ?
        ');
        $stmt->execute([$titolo, $genere, $regista, $data, $id]);
    }

    public function delete(int $id): void {
        $stmt = $this->db->prepare('DELETE FROM Film WHERE id_film = ?');
        $stmt->execute([$id]);
    }
}