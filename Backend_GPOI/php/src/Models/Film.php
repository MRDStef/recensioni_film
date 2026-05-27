<?php

namespace RecensioniFilm\Models;

use RecensioniFilm\Config\Database;

class Film
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getConnection();
    }

    public function findAll(): array
    {
        $result = $this->db->query("SELECT * FROM film");
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function findById(int $id): ?array
    {
        $stmt = $this->db->prepare("SELECT * FROM film WHERE id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result()->fetch_assoc();
        return $result ?: null;
    }

    public function create(string $titolo, string $regista, int $anno, string $genere, string $descrizione, string $locandina_url): bool
    {
        $stmt = $this->db->prepare(
            "INSERT INTO film (titolo, regista, anno, genere, descrizione, locandina_url) VALUES (?, ?, ?, ?, ?, ?)"
        );
        $stmt->bind_param("ssisss", $titolo, $regista, $anno, $genere, $descrizione, $locandina_url);
        return $stmt->execute();
    }

    public function update(int $id, string $titolo, string $regista, int $anno, string $genere, string $descrizione, string $locandina_url): bool
    {
        $stmt = $this->db->prepare(
            "UPDATE film SET titolo=?, regista=?, anno=?, genere=?, descrizione=?, locandina_url=? WHERE id=?"
        );
        $stmt->bind_param("ssisssi", $titolo, $regista, $anno, $genere, $descrizione, $locandina_url, $id);
        return $stmt->execute();
    }

    public function delete(int $id): bool
    {
        $stmt = $this->db->prepare("DELETE FROM film WHERE id = ?");
        $stmt->bind_param("i", $id);
        return $stmt->execute();
    }
}