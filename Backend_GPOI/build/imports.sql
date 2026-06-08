INSERT INTO `Account` (`id_account`, `nome_utente`, `email`, `ruolo`, `password`, `avatar_url`, `created_at`) VALUES
(4, 'admin', 'admin@test.it', 'admin', '$2y$10$ZJeB3lOol6VvW6E6U9M5..JI6VXc6O/bz0Jsk83eXwUAMOjuSOShy', NULL, '2026-05-30 15:06:00'),
-- Utenti aggiuntivi (password: password123)
(5, 'mario_rossi', 'mario@test.it', 'utente', '$2y$10$KuuX.IYaOkcsoz//XX8dDOhFLSbfVQhBdr/cpsHD5YKL3xWBBa45K', NULL, '2026-05-28 10:00:00'),
(6, 'giulia_bianchi', 'giulia@test.it', 'utente', '$2y$10$KuuX.IYaOkcsoz//XX8dDOhFLSbfVQhBdr/cpsHD5YKL3xWBBa45K', NULL, '2026-05-28 11:30:00'),
(7, 'luca_verdi', 'luca@test.it', 'utente', '$2y$10$KuuX.IYaOkcsoz//XX8dDOhFLSbfVQhBdr/cpsHD5YKL3xWBBa45K', NULL, '2026-05-29 09:15:00');

INSERT INTO `Film` (`id_film`, `titolo`, `genere`, `regista`, `data_pubblicazione`, `locandina_url`, `descrizione`) VALUES
(25, 'Inception', 'Fantascienza', 'Christopher Nolan', '2010-09-24', 'uploads/locandine/locandine_6a1aedc5e9f832.56698675.jpg', 'La tua mente è la scena del crimine. Dom Cobb è un ladro professionista specializzato nell\'estrarre segreti preziosi dal profondo del subconscio durante lo stato di sogno. Questa sua rara abilità lo ha reso un rifugiato internazionale, costandogli tutto ciò che ama. Ora gli viene offerta una possibilità di riscatto: per riavere la sua vita, non dovrà rubare un\'idea, ma impiantarla. Questa volta il colpo perfetto non si chiama estrazione, ma Inception.'),
(26, 'Interstellar', 'Fantascienza', 'Christopher Nolan', '2014-11-06', 'uploads/locandine/locandine_6a1aee40e669e2.92591412.jpg', 'La fine della Terra non sarà la nostra fine. In un futuro vicino, i cambiamenti climatici e una piaga globale stanno distruggendo l\'agricoltura, condannando l\'umanità all\'estinzione. Cooper (Matthew McConaughey), un ex pilota della NASA diventato agricoltore, viene reclutato per una missione segreta disperata. Insieme a un team di scienziati, dovrà attraversare un misterioso wormhole (un ponte spaziotemporale) scoperto vicino a Saturno, per viaggiare oltre i confini della nostra galassia e trovare un nuovo pianeta abitabile dove trasferire la specie umana.'),
(27, 'Shrek', 'Animazione', 'Andrew Adamson, Vicky Jenson', '2001-07-15', 'uploads/locandine/locandine_6a1aeef042d973.65208877.jpg', 'C\'era una volta un orco verde e solitario di nome Shrek, la cui amata e tranquilla palude viene improvvisamente invasa da fastidiose creature delle fiabe, bandite dal malvagio Lord Farquaad. Per riavere la sua casa, Shrek stringe un patto con il tiranno: dovrà salvare la bellissima Principessa Fiona, prigioniera in una torre sorvegliata da un drago sputafuoco. Accompagnato da Ciuchino, un mulo parlante logorroico e fin troppo ottimista, Shrek intraprenderà un viaggio che ribalterà per sempre tutte le regole delle favole tradizionali.'),
(28, 'Shrek 2', 'Animazione', 'Andrew Adamson', '2004-12-17', 'uploads/locandine/locandine_6a1aef9e398446.89072004.jpg', 'Il \"vissero felici e contenti\" non è mai stato così lontano. Di ritorno dal loro viaggio di nozze, Shrek e la Principessa Fiona vengono invitati nel regno di Molto Molto Lontano per celebrare il matrimonio con i genitori di lei. C\'è solo un piccolo problema: il Re e la Regina non sanno che sia la figlia che il genero sono due enormi orchi verdi. Mentre il suocero complotta per eliminare l\'orco, Shrek si ritrova a dover combattere contro una perfida Fata Madrina, un vanitoso Principe Azzurro e un famigerato cacciatore di taglie: il Gatto con gli Stivali.');

-- Nuovi film (locandine già presenti in public/uploads/locandine)
INSERT INTO `Film` (`titolo`, `genere`, `regista`, `data_pubblicazione`, `locandina_url`, `descrizione`) VALUES
('Il Padrino', 'Drammatico', 'Francis Ford Coppola', '1972-03-24', 'uploads/locandine/locandine_6a1aea06b6be39.75235597.jpg', 'La saga della famiglia Corleone: potere, onore e tradimento nel cuore della mafia italo-americana.'),
('Pulp Fiction', 'Crime', 'Quentin Tarantino', '1994-10-14', 'uploads/locandine/locandine_6a1aeaaa586d52.49902418.jpg', 'Storie intrecciate di criminali, pugili e trippy burger a Los Angeles, raccontate con ritmo e ironia tagliente.'),
('Il Signore degli Anelli: La Compagnia dell''Anello', 'Fantasy', 'Peter Jackson', '2001-12-19', 'uploads/locandine/locandine_6a1aeb0bcf7ff9.72393578.jpg', 'Frodo Baggins parte per distruggere l''Anello del Potere, accompagnato da una compagnia eterogenea attraverso la Terra di Mezzo.'),
('Matrix', 'Fantascienza', 'Lana e Lilly Wachowski', '1999-03-31', 'uploads/locandine/locandine_6a1aeb814a9531.26937146.jpg', 'Neo scopre che la realtà è una simulazione e si unisce alla resistenza contro le macchine che controllano l''umanità.'),
('Titanic', 'Romantico', 'James Cameron', '1997-12-19', 'uploads/locandine/locandine_6a1aee40e669e2.92591412.jpg', 'La storia d''amore tra Jack e Rose sul tragico transatlantico che scontra un iceberg nella notte del 1912.'),
('La vita è bella', 'Commedia drammatica', 'Roberto Benigni', '1997-12-20', 'uploads/locandine/locandine_6a1aeef042d973.65208877.jpg', 'Un padre usa fantasia e umorismo per proteggere il figlio dai orrori di un campo di concentramento.'),
('Il sospetto', 'Thriller', 'Bryan Singer', '1995-08-16', 'uploads/locandine/locandine_6a1aef9e398446.89072004.jpg', 'Un giovane con problemi alla gamba si insinua nel circolo ristretto di un veterano criminale, alimentando sospetti e tensione.');

-- Recensioni (id_account: 4=admin, 5=mario, 6=giulia, 7=luca — dopo INSERT Account sopra)
INSERT INTO `Recensione` (`id_film`, `id_account`, `valutazione`, `descrizione`, `created_at`) VALUES
(25, 4, 5, 'Capolavoro assoluto: stratificato, emozionante e da rivedere più volte.', '2026-05-29 18:00:00'),
(25, 5, 5, 'Il finale mi ha lasciato senza parole. Nolan al top.', '2026-05-30 09:20:00'),
(25, 6, 4, 'Ottimo film, ma a tratti faticoso da seguire al primo visionaggio.', '2026-05-30 14:45:00'),
(26, 4, 5, 'Sci-fi poetica e potentissima sul legame padre-figlia.', '2026-05-28 20:10:00'),
(26, 7, 5, 'Le scene nello spazio e la colonna sonora sono indimenticabili.', '2026-05-29 11:00:00'),
(26, 6, 4, 'Lungo ma coinvolgente; qualche passaggio scientifico è discutibile.', '2026-05-30 16:30:00'),
(27, 5, 5, 'Divertentissimo per grandi e piccini, citazioni iconiche.', '2026-05-27 19:00:00'),
(27, 6, 5, 'Una rivisitazione brillante delle fiabe, Ciuchino spacca.', '2026-05-28 21:15:00'),
(27, 7, 4, 'Molto simpatico, qualche battuta un po'' ripetitiva.', '2026-05-29 10:40:00'),
(28, 4, 4, 'Sequel solido con il Gatto con gli Stivali protagonista involontario.', '2026-05-29 12:00:00'),
(28, 5, 4, 'Meno fresco del primo ma comunque molto divertente.', '2026-05-30 08:50:00'),
(28, 6, 3, 'Troppi personaggi secondari, perde un po'' il fascino originale.', '2026-05-30 17:20:00');

-- Recensioni sui film appena inseriti (subquery per id_film da titolo)
INSERT INTO `Recensione` (`id_film`, `id_account`, `valutazione`, `descrizione`, `created_at`)
SELECT f.id_film, 4, 5, 'Un classico intramontabile della storia del cinema.', '2026-05-30 19:00:00' FROM Film f WHERE f.titolo = 'Il Padrino'
UNION ALL SELECT f.id_film, 5, 5, 'Brando e Pacino leggendari. Ogni scena è perfetta.', '2026-05-30 20:10:00' FROM Film f WHERE f.titolo = 'Il Padrino'
UNION ALL SELECT f.id_film, 6, 5, 'Pacing lento ma ogni minuto è giustificato.', '2026-05-31 09:00:00' FROM Film f WHERE f.titolo = 'Il Padrino'
UNION ALL SELECT f.id_film, 7, 4, 'Capolavoro, ma richiede pazienza per chi non ama i drammi lunghi.', '2026-05-31 11:30:00' FROM Film f WHERE f.titolo = 'Il Padrino'
UNION ALL SELECT f.id_film, 4, 5, 'Dialoghi memorabili e montaggio geniale.', '2026-05-29 22:00:00' FROM Film f WHERE f.titolo = 'Pulp Fiction'
UNION ALL SELECT f.id_film, 5, 4, 'Stile unico, un po'' violento per i miei gusti.', '2026-05-30 10:00:00' FROM Film f WHERE f.titolo = 'Pulp Fiction'
UNION ALL SELECT f.id_film, 6, 5, 'Tarantino al massimo, cast stellare.', '2026-05-30 15:00:00' FROM Film f WHERE f.titolo = 'Pulp Fiction'
UNION ALL SELECT f.id_film, 4, 5, 'La Terra di Mezzo prende vita in modo spettacolare.', '2026-05-28 18:30:00' FROM Film f WHERE f.titolo = 'Il Signore degli Anelli: La Compagnia dell''Anello'
UNION ALL SELECT f.id_film, 7, 5, 'Epico, emozionante, perfetto adattamento del libro.', '2026-05-29 20:00:00' FROM Film f WHERE f.titolo = 'Il Signore degli Anelli: La Compagnia dell''Anello'
UNION ALL SELECT f.id_film, 5, 4, 'Tre ore che volano, paesaggi mozzafiato.', '2026-05-30 12:30:00' FROM Film f WHERE f.titolo = 'Il Signore degli Anelli: La Compagnia dell''Anello'
UNION ALL SELECT f.id_film, 4, 5, 'Rivoluzionario: effetti speciali e filosofia ancora attuali.', '2026-05-27 21:00:00' FROM Film f WHERE f.titolo = 'Matrix'
UNION ALL SELECT f.id_film, 6, 5, 'Keanu Reeves perfetto, sequenze d''azione iconiche.', '2026-05-28 16:00:00' FROM Film f WHERE f.titolo = 'Matrix'
UNION ALL SELECT f.id_film, 7, 4, 'Ottimo primo capitolo, i sequel sono meno forti.', '2026-05-29 14:20:00' FROM Film f WHERE f.titolo = 'Matrix'
UNION ALL SELECT f.id_film, 5, 4, 'Melodramma hollywoodiano ma funziona ancora oggi.', '2026-05-30 13:00:00' FROM Film f WHERE f.titolo = 'Titanic'
UNION ALL SELECT f.id_film, 6, 3, 'Bello ma un po'' sdolcinato al secondo atto.', '2026-05-30 18:00:00' FROM Film f WHERE f.titolo = 'Titanic'
UNION ALL SELECT f.id_film, 4, 5, 'Benigni commuove senza retorica, capolavoro italiano.', '2026-05-29 17:00:00' FROM Film f WHERE f.titolo = 'La vita è bella'
UNION ALL SELECT f.id_film, 7, 5, 'Equilibrio perfetto tra comicità e dramma storico.', '2026-05-30 19:30:00' FROM Film f WHERE f.titolo = 'La vita è bella'
UNION ALL SELECT f.id_film, 6, 4, 'Final twist memorabile, Kevin Spacey azzeccato.', '2026-05-31 10:00:00' FROM Film f WHERE f.titolo = 'Il sospetto'
UNION ALL SELECT f.id_film, 5, 5, 'Thriller serrato con uno dei colpi di scena migliori degli anni 90.', '2026-05-31 12:00:00' FROM Film f WHERE f.titolo = 'Il sospetto';