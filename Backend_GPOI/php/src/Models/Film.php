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
        $stmt = $this->db->prepare("SELECT * FROM film WHERE id_film = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result()->fetch_assoc();
        return $result ?: null;
    }

    public function create(string $titolo, string $genere, string $regista, int $data_pubblicazione, string $locandina_url, string $descrizione): bool
    {
        $stmt = $this->db->prepare(
            "INSERT INTO film (titolo, genere, regista, data_pubblicazione, locandina_url, descrizione) VALUES (?, ?, ?, ?, ?, ?)"
        );
        $stmt->bind_param("ssssss", $titolo, $regista, $data_pubblicazione, $genere, $descrizione, $locandina_url);
        return $stmt->execute();
    }

    public function update(int $id_film, string $titolo, string $genere, string $regista, int $data_pubblicazione, string $locandina_url, string $descrizione): bool
    {
        $stmt = $this->db->prepare(
            "UPDATE film SET titolo=?, genere=?, regista=?, data_pubblicazione=?, locandina_url=?, descrizione=? WHERE id_film=?"
        );
        $stmt->bind_param("ssssssi", $titolo, $genere, $regista, $data_pubblicazione, $locandina_url, $descrizione, $id_film);
        return $stmt->execute();
    }

    public function delete(int $id_film): bool
    {
        $stmt = $this->db->prepare("DELETE FROM film WHERE id_film = ?");
        $stmt->bind_param("i", $id_film);
        return $stmt->execute();
    }
}