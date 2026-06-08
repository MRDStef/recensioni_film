INSERT INTO Account (nome_utente, email, ruolo, password, created_at)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 150
)
SELECT
    CONCAT('utente_', n),
    CONCAT('utente_', n, '@test.it'),
    CASE WHEN n = 1 THEN 'admin' ELSE 'utente' END,
    '$2y$10$KuuX.IYaOkcsoz//XX8dDOhFLSbfVQhBdr/cpsHD5YKL3xWBBa45K',
    DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY)
FROM seq;