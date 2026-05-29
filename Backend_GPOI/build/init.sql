CREATE DATABASE IF NOT EXISTS recensioni_film;
USE recensioni_film;

CREATE TABLE IF NOT EXISTS Film (
    id_film BIGINT PRIMARY KEY AUTO_INCREMENT,
    titolo VARCHAR(255) NOT NULL UNIQUE,
    genere VARCHAR(255) NOT NULL,
    regista VARCHAR(255),
    data_pubblicazione DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Account (
    id_account BIGINT PRIMARY KEY AUTO_INCREMENT,
    nome_utente VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    ruolo ENUM("moderatore", "utente") NOT NULL
);

CREATE TABLE IF NOT EXISTS Recensione (
    id_recensione BIGINT PRIMARY KEY AUTO_INCREMENT,
    id_film BIGINT NOT NULL,
    id_account BIGINT NOT NULL,
    valutazione INT NOT NULL CHECK (valutazione >= 1 AND valutazione <= 5),
    descrizione VARCHAR(255),

    FOREIGN KEY (id_film) REFERENCES Film(id_film),
    FOREIGN KEY (id_account) REFERENCES Account(id_account)
);