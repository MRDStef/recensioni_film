SET NAMES utf8mb4;

DELETE FROM Recensione;
DELETE FROM Film;

INSERT INTO Film (titolo, genere, regista, data_pubblicazione, locandina_url, descrizione) VALUES
-- Fantascienza (6)
('Inception', 'Fantascienza', 'Christopher Nolan', '2010-07-16', 'uploads/locandine/catalog_f01.jpg', 'Un team entra nei sogni per impiantare un''idea nel subconscio di un obiettivo.'),
('Interstellar', 'Fantascienza', 'Christopher Nolan', '2014-11-07', 'uploads/locandine/catalog_f02.jpg', 'Viaggio oltre la galassia per salvare l''umanità da un pianeta morente.'),
('Matrix', 'Fantascienza', 'Lana e Lilly Wachowski', '1999-03-31', 'uploads/locandine/catalog_f03.jpg', 'Neo scopre che la realtà è una simulazione controllata dalle macchine.'),
('Blade Runner 2049', 'Fantascienza', 'Denis Villeneuve', '2017-10-06', 'uploads/locandine/catalog_f04.jpg', 'Un replicante scopre un segreto che potrebbe cambiare il futuro dell''umanità.'),
('Arrival', 'Fantascienza', 'Denis Villeneuve', '2016-11-11', 'uploads/locandine/catalog_f05.jpg', 'Una linguista tenta di comunicare con alieni arrivati sulla Terra.'),
('Dune', 'Fantascienza', 'Denis Villeneuve', '2021-09-15', 'uploads/locandine/catalog_f06.jpg', 'Paul Atreides guida la resistenza sul deserto di Arrakis.'),

-- Animazione (6)
('Shrek', 'Animazione', 'Andrew Adamson, Vicky Jenson', '2001-04-22', 'uploads/locandine/catalog_f07.jpg', 'Un orco verde parte per salvare una principessa e riprendersi la palude.'),
('Shrek 2', 'Animazione', 'Andrew Adamson', '2004-05-19', 'uploads/locandine/catalog_f08.jpg', 'Shrek e Fiona visitano il regno di Molto Molto Lontano.'),
('Toy Story', 'Animazione', 'John Lasseter', '1995-11-22', 'uploads/locandine/catalog_f09.jpg', 'I giocattoli prendono vita quando i bambini non guardano.'),
('Il Re Leone', 'Animazione', 'Roger Allers, Rob Minkoff', '1994-06-15', 'uploads/locandine/catalog_f10.jpg', 'Simba deve riconquistare il regno dal malvagio zio Scar.'),
('Inside Out', 'Animazione', 'Pete Docter', '2015-06-17', 'uploads/locandine/catalog_f11.jpg', 'Le emozioni dentro la mente di Riley la guidano nella crescita.'),
('Spider-Man: Across the Spider-Verse', 'Animazione', 'Joaquim Dos Santos', '2023-05-31', 'uploads/locandine/catalog_f12.jpg', 'Miles Morales attraversa il multiverso degli Spider-Man.'),

-- Drammatico (6)
('Il Padrino', 'Drammatico', 'Francis Ford Coppola', '1972-03-24', 'uploads/locandine/catalog_f13.jpg', 'La saga della famiglia Corleone tra potere e tradimento.'),
('Forrest Gump', 'Drammatico', 'Robert Zemeckis', '1994-07-06', 'uploads/locandine/catalog_f14.jpg', 'La vita straordinaria di un uomo semplice attraverso la storia americana.'),
('Parasite', 'Drammatico', 'Bong Joon-ho', '2019-05-30', 'uploads/locandine/catalog_f15.jpg', 'Due famiglie, ricchezza e povertà, intrecciano destini inquietanti.'),
('12 uomini arrabbiati', 'Drammatico', 'Sidney Lumet', '1957-04-10', 'uploads/locandine/catalog_f16.jpg', 'Una giuria deve decidere il destino di un giovane imputato.'),
('Schindler''s List', 'Drammatico', 'Steven Spielberg', '1993-12-15', 'uploads/locandine/catalog_f17.jpg', 'Oskar Schindler salva centinaia di ebrei durante l''Olocausto.'),
('Whiplash', 'Drammatico', 'Damien Chazelle', '2014-10-16', 'uploads/locandine/catalog_f18.jpg', 'Un batterista e un insegnante spingono oltre ogni limite.'),

-- Azione (6)
('The Dark Knight', 'Azione', 'Christopher Nolan', '2008-07-18', 'uploads/locandine/catalog_f19.jpg', 'Batman affronta il caos seminato dal Joker a Gotham City.'),
('Mad Max: Fury Road', 'Azione', 'George Miller', '2015-05-15', 'uploads/locandine/catalog_f20.jpg', 'Inseguimento epico nel deserto per sfuggire a un tiranno.'),
('Gladiator', 'Azione', 'Ridley Scott', '2000-05-05', 'uploads/locandine/catalog_f21.jpg', 'Un generale romano diventa gladiatore per vendicare la famiglia.'),
('Die Hard', 'Azione', 'John McTiernan', '1988-07-15', 'uploads/locandine/catalog_f22.jpg', 'Un poliziotto sventa un blitz terroristico in un grattacielo.'),
('Mission: Impossible - Fallout', 'Azione', 'Christopher McQuarrie', '2018-07-27', 'uploads/locandine/catalog_f23.jpg', 'Ethan Hunt deve fermare un''arma nucleare.'),
('John Wick', 'Azione', 'Chad Stahelski', '2014-10-24', 'uploads/locandine/catalog_f24.jpg', 'Un ex assassino torna in azione per vendetta.'),

-- Commedia (6)
('La vita è bella', 'Commedia', 'Roberto Benigni', '1997-12-20', 'uploads/locandine/catalog_f25.jpg', 'Un padre protegge il figlio con fantasia in un campo di concentramento.'),
('Il grande Lebowski', 'Commedia', 'Joel Coen', '1998-03-06', 'uploads/locandine/catalog_f26.jpg', 'Il Dude viene trascinato in un caso di rapimento assurdo.'),
('Superbad', 'Commedia', 'Greg Mottola', '2007-08-17', 'uploads/locandine/catalog_f27.jpg', 'Due amici cercano di vivere una notte indimenticabile prima del diploma.'),
('Mean Girls', 'Commedia', 'Mark Waters', '2004-04-30', 'uploads/locandine/catalog_f28.jpg', 'Una liceale naviga le regole non scritte del gruppo più popolare.'),
('Una notte da leoni', 'Commedia', 'Todd Phillips', '2009-06-05', 'uploads/locandine/catalog_f29.jpg', 'Tre amici cercano di ricordare la notte folle a Las Vegas.'),
('Love Actually', 'Commedia', 'Richard Curtis', '2003-11-14', 'uploads/locandine/catalog_f30.jpg', 'Storie d''amore intrecciate a Londra nel periodo natalizio.'),

-- Thriller (6)
('Il sospetto', 'Thriller', 'Bryan Singer', '1995-08-16', 'uploads/locandine/catalog_f31.jpg', 'Un sopravvissuto racconta ai federali un colpo di scena leggendario.'),
('Se7en', 'Thriller', 'David Fincher', '1995-09-22', 'uploads/locandine/catalog_f32.jpg', 'Due detective inseguono un serial killer che usa i sette peccati capitali.'),
('The Silence of the Lambs', 'Thriller', 'Jonathan Demme', '1991-02-14', 'uploads/locandine/catalog_f33.jpg', 'Una agente FBI chiede aiuto a Hannibal Lecter per catturare un assassino.'),
('Gone Girl', 'Thriller', 'David Fincher', '2014-10-03', 'uploads/locandine/catalog_f34.jpg', 'La sparizione di una donna rivela segreti di una coppia perfetta.'),
('Zodiac', 'Thriller', 'David Fincher', '2007-03-02', 'uploads/locandine/catalog_f35.jpg', 'Ossessione per l''assassino dello Zodiaco che terrorizzò la California.'),
('Shutter Island', 'Thriller', 'Martin Scorsese', '2010-02-19', 'uploads/locandine/catalog_f36.jpg', 'Un marshal indaga in un ospedale psichiatrico su un''isola remota.');

INSERT INTO Recensione (id_film, id_account, valutazione, descrizione, created_at)
SELECT f.id_film, 4, 5, 'Capolavoro del genere, da vedere assolutamente.', NOW() FROM Film f WHERE f.titolo = 'Inception'
UNION ALL SELECT f.id_film, 5, 5, 'Complesso ma gratificante al secondo visionaggio.', NOW() FROM Film f WHERE f.titolo = 'Inception'
UNION ALL SELECT f.id_film, 6, 4, 'Ottimo concept, qualche scena un po'' confusa.', NOW() FROM Film f WHERE f.titolo = 'Inception'
UNION ALL SELECT f.id_film, 4, 5, 'Emozionante e visivamente spettacolare.', NOW() FROM Film f WHERE f.titolo = 'Interstellar'
UNION ALL SELECT f.id_film, 7, 5, 'La colonna sonora da sola vale il biglietto.', NOW() FROM Film f WHERE f.titolo = 'Interstellar'
UNION ALL SELECT f.id_film, 5, 5, 'Shrek è intramontabile, umorismo perfetto.', NOW() FROM Film f WHERE f.titolo = 'Shrek'
UNION ALL SELECT f.id_film, 6, 4, 'Divertente per tutta la famiglia.', NOW() FROM Film f WHERE f.titolo = 'Shrek 2'
UNION ALL SELECT f.id_film, 4, 5, 'Il miglior film sulla mafia di sempre.', NOW() FROM Film f WHERE f.titolo = 'Il Padrino'
UNION ALL SELECT f.id_film, 7, 5, 'Pacino e Brando leggendari.', NOW() FROM Film f WHERE f.titolo = 'Il Padrino'
UNION ALL SELECT f.id_film, 5, 5, 'Heath Ledger irreale come Joker.', NOW() FROM Film f WHERE f.titolo = 'The Dark Knight'
UNION ALL SELECT f.id_film, 6, 5, 'Azione pura e adrenalina per due ore.', NOW() FROM Film f WHERE f.titolo = 'Mad Max: Fury Road'
UNION ALL SELECT f.id_film, 4, 5, 'Benigni commuove senza retorica.', NOW() FROM Film f WHERE f.titolo = 'La vita è bella'
UNION ALL SELECT f.id_film, 7, 4, 'Commedia romantica natalizia ben scritta.', NOW() FROM Film f WHERE f.titolo = 'Love Actually'
UNION ALL SELECT f.id_film, 5, 5, 'Fincher al massimo, finale terrificante.', NOW() FROM Film f WHERE f.titolo = 'Se7en'
UNION ALL SELECT f.id_film, 6, 5, 'Thriller psicologico che ti tiene incollato.', NOW() FROM Film f WHERE f.titolo = 'Gone Girl';
