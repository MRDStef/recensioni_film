INSERT INTO Account (nome_utente, email, ruolo) VALUES
('marco_piva', 'marco.piva@email.it', 'utente'),
('sofia_regia', 'sofia.r@email.com', 'utente'),
('luca_blocks', 'luca.b@email.net', 'utente'),
('elena_cinefila', 'elena.c@email.it', 'utente'),
('giovanni_reviews', 'giò.rev@email.com', 'utente'),
('admin_cine', 'admin.moderatore@recensionifilm.com', 'moderatore');

INSERT INTO Film (titolo, genere, regista, data_pubblicazione) VALUES
('Inception', 'Fantascienza', 'Christopher Nolan', '2010-09-24'),
('Il Padrino', 'Drammatico', 'Francis Ford Coppola', '1972-09-21'),
('Pulp Fiction', 'Crime', 'Quentin Tarantino', '1994-10-28'),
('Interstellar', 'Fantascienza', 'Christopher Nolan', '2014-11-06'),
('La Vita è Bella', 'Drammatico', 'Roberto Benigni', '1997-12-20');

INSERT INTO Recensione (id_film, id_account, valutazione, descrizione) VALUES
-- Recensioni per Inception (Film 1)
(1, 1, 5, 'Un capolavoro assoluto, trama complessa e cast eccezionale.'),
(1, 3, 4, 'Molto bello, ma a tratti un po troppo confusionario.'),

-- Recensioni per Il Padrino (Film 2)
(2, 2, 5, 'La storia del cinema. Pietra miliare intramontabile.'),
(2, 4, 5, 'Marlon Brando monumentale. Film perfetto.'),

-- Recensioni per Pulp Fiction (Film 3)
(3, 1, 4, 'Dialoghi fantastici e regia iconica. Tipico stile Tarantino.'),
(3, 5, 5, 'Il mio film preferito in assoluto!'),

-- Recensioni per Interstellar (Film 4)
(4, 3, 5, 'Colonna sonora da brividi e risvolti scientifici affascinanti.'),
(4, 2, 3, 'Visivamente spettacolare, ma la parte finale non mi ha convinto del tutto.'),

-- Recensioni per La Vita è Bella (Film 5)
(5, 4, 5, 'Poetico, commovente e storicamente potentissimo. Capolavoro di Benigni.'),
(5, 5, 4, 'Fa ridere e piangere allo stesso tempo. Da vedere assolutamente.');