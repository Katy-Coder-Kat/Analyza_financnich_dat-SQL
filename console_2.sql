USE financial21_99;
SHOW TABLES;
DESCRIBE client;

SELECT *
FROM client
LIMIT 10;
SELECT * FROM client LIMIT 10;
SELECT COUNT(*) AS total_clients FROM client;
SELECT COUNT(*) AS celkovy_pocet_splacenych FROM loan WHERE status IN ('A', 'C');
SELECT COUNT(*) AS loans_without_client
FROM loan l
LEFT JOIN client c ON l.account_id = c.client_id
WHERE l.status IN ('A', 'C') AND c.client_id IS NULL;
SELECT
    c.gender,
    SUM(l.amount) AS celkova_vyse_splacenych_uveru,
    COUNT(l.loan_id) AS pocet_splacenych_uveru
FROM loan l
JOIN account a ON l.account_id = a.account_id
JOIN client c ON a.account_id = c.client_id
WHERE l.status IN ('A', 'C')
GROUP BY c.gender;
SELECT COUNT(*) AS loans_without_account
FROM loan l
LEFT JOIN account a ON l.account_id = a.account_id
WHERE l.status IN ('A', 'C') AND a.account_id IS NULL;
SELECT
    c.gender,
    SUM(l.amount) AS celkova_vyse_splacenych_uveru,
    COUNT(l.loan_id) AS pocet_splacenych_uveru
FROM loan l
JOIN account a ON l.account_id = a.account_id
JOIN disp d ON a.account_id = d.account_id
JOIN client c ON d.client_id = c.client_id
WHERE l.status IN ('A', 'C')
GROUP BY c.gender;
SELECT
    l.loan_id,
    COUNT(d.disp_id) AS pocet_disponentu
FROM loan l
JOIN account a ON l.account_id = a.account_id
JOIN disp d ON a.account_id = d.account_id
WHERE l.status IN ('A', 'C')
GROUP BY l.loan_id
HAVING COUNT(d.disp_id) > 1;
SELECT
    c.gender,
    SUM(l.amount) AS celkova_vyse_splacenych_uveru,
    COUNT(DISTINCT l.loan_id) AS pocet_splacenych_uveru
FROM loan l
JOIN account a ON l.account_id = a.account_id
JOIN disp d ON a.account_id = d.account_id
JOIN client c ON d.client_id = c.client_id
WHERE l.status IN ('A', 'C')
  AND d.type = 'OWNER'
GROUP BY c.gender;
CREATE TEMPORARY TABLE temp_splacene_uvery AS
SELECT
    c.client_id,
    c.gender,
    c.birth_date,
    l.loan_id,
    l.amount
FROM loan l
JOIN account a ON l.account_id = a.account_id
JOIN disp d ON a.account_id = d.account_id
JOIN client c ON d.client_id = c.client_id
WHERE l.status IN ('A', 'C')
  AND d.type = 'OWNER';
SELECT * FROM temp_splacene_uvery LIMIT 10;
SELECT
    c.district_id,
    COUNT(c.client_id) AS pocet_klientu
FROM client c
JOIN disp d ON c.client_id = d.client_id
WHERE d.type = 'OWNER'
GROUP BY c.district_id
ORDER BY pocet_klientu DESC
LIMIT 1;
SELECT
    a.district_id,
    COUNT(l.loan_id) AS pocet_splacenych_uveru
FROM loan l
JOIN account a ON l.account_id = a.account_id
JOIN disp d ON a.account_id = d.account_id
JOIN client c ON d.client_id = c.client_id
WHERE d.type = 'OWNER' AND l.status IN ('A', 'C')
GROUP BY a.district_id
ORDER BY pocet_splacenych_uveru DESC
LIMIT 1;
SELECT
    a.district_id,
    SUM(l.amount) AS celkova_vyse_splacenych_uveru
FROM loan l
JOIN account a ON l.account_id = a.account_id
JOIN disp d ON a.account_id = d.account_id
JOIN client c ON d.client_id = c.client_id
WHERE d.type = 'OWNER' AND l.status IN ('A', 'C')
GROUP BY a.district_id
ORDER BY celkova_vyse_splacenych_uveru DESC
LIMIT 1;

SELECT
    a.district_id,
    COUNT(l.loan_id) AS pocet_splacenych_uveru
FROM loan l
JOIN account a ON l.account_id = a.account_id
JOIN disp d ON a.account_id = d.account_id
JOIN client c ON d.client_id = c.client_id
WHERE d.type = 'OWNER' AND l.status IN ('A', 'C')
GROUP BY a.district_id
ORDER BY pocet_splacenych_uveru DESC;
SELECT * FROM district WHERE district_id = 1;
WITH loans_per_district AS (
    SELECT
        c.district_id,
        COUNT(DISTINCT c.client_id) AS customer_amount,
        SUM(l.amount) AS loans_given_amount,
        COUNT(l.loan_id) AS loans_given_count
    FROM loan l
    JOIN account a ON l.account_id = a.account_id
    JOIN disp d ON a.account_id = d.account_id
    JOIN client c ON d.client_id = c.client_id
    WHERE l.status IN ('A', 'C')
    GROUP BY c.district_id
)
SELECT
    district_id,
    customer_amount,
    loans_given_amount,
    loans_given_count,
    ROUND(loans_given_amount / SUM(loans_given_amount) OVER (), 4) AS amount_share
FROM loans_per_district
ORDER BY amount_share DESC;

DESCRIBE account;
SELECT DISTINCT type FROM trans;
SELECT
    a.account_id,
    COUNT(t.trans_id) AS transaction_count
FROM account a
LEFT JOIN trans t ON a.account_id = t.account_id
GROUP BY a.account_id
ORDER BY transaction_count DESC;
SELECT c.client_id, c.birth_date
FROM client c
WHERE EXTRACT(YEAR FROM c.birth_date) > 1990;

SELECT COUNT(client_id)
FROM (
    SELECT c.client_id
    FROM client c
    JOIN disp d ON c.client_id = d.client_id
    JOIN account a ON d.account_id = a.account_id
    JOIN loan l ON a.account_id = l.account_id
    GROUP BY c.client_id
    HAVING COUNT(l.loan_id) > 5
) AS subquery;
SELECT COUNT(client_id)
FROM (
    SELECT c.client_id, SUM(l.amount - l.payments) AS balance
    FROM client c
    JOIN disp d ON c.client_id = d.client_id
    JOIN account a ON d.account_id = a.account_id
    JOIN loan l ON a.account_id = l.account_id
    GROUP BY c.client_id
    HAVING SUM(l.amount - l.payments) > 1000
) AS subquery;
SELECT COUNT(*)
FROM client
WHERE EXTRACT(YEAR FROM birth_date) > 1980;
SELECT client_id, COUNT(loan_id) AS loans_count
FROM loan
JOIN disp USING (account_id)
WHERE True
GROUP BY client_id
HAVING COUNT(loan_id) > 3;
SELECT client_id, SUM(amount - payments) AS balance
FROM loan
JOIN disp USING (account_id)
WHERE True
GROUP BY client_id
HAVING SUM(amount - payments) > 1000;
SELECT
    c.client_id,
    SUM(l.amount - l.payments) AS client_balance,
    COUNT(l.loan_id) AS loans_amount
FROM loan AS l
    INNER JOIN account a USING (account_id)
    INNER JOIN disp d USING (account_id)
    INNER JOIN client c USING (client_id)
WHERE True
    AND l.status IN ('A', 'C')
    AND d.type = 'OWNER'
    AND EXTRACT(YEAR FROM c.birth_date) > 1980
GROUP BY c.client_id
HAVING COUNT(l.loan_id) > 1;
SELECT
    c.client_id,
    SUM(l.amount - l.payments) AS client_balance,
    COUNT(l.loan_id) AS loans_amount
FROM loan AS l
    INNER JOIN account a USING (account_id)
    INNER JOIN disp d USING (account_id)
    INNER JOIN client c USING (client_id)
WHERE True
    AND l.status IN ('A', 'C')
    AND d.type = 'OWNER'
    AND EXTRACT(YEAR FROM c.birth_date) > 1980
GROUP BY c.client_id
HAVING COUNT(l.loan_id) > 2;
DESCRIBE disp;
DESCRIBE client;
DESCRIBE district;
SELECT * FROM district LIMIT 5;
SELECT
    c.client_id,
    c.birth_date,
    d.district_id,
    d.A2 AS district_name,
    d.A3 AS region_name
FROM client c
JOIN district d ON c.district_id = d.district_id
LIMIT 10;
DESCRIBE card;
WITH cte AS (
    SELECT
        c2.client_id,
        c.card_id,
        DATE_ADD(c.issued, INTERVAL 3 YEAR) AS expiration_date,
        d2.A3 AS client_address
    FROM
        financial21_99.card AS c
    INNER JOIN
        financial21_99.disp AS d USING (disp_id)
    INNER JOIN
        financial21_99.client AS c2 USING (client_id)
    INNER JOIN
        financial21_99.district AS d2 USING (district_id)
)
SELECT *
FROM cte
WHERE '2000-01-01' BETWEEN DATE_ADD(expiration_date, INTERVAL -7 DAY) AND expiration_date;
CREATE TABLE IF NOT EXISTS financial21_99.cards_at_expiration (
    client_id       INT                      NOT NULL,
    card_id         INT DEFAULT 0            NOT NULL,
    expiration_date DATE                     NULL,
    client_address  VARCHAR(15) CHARACTER SET utf8 NOT NULL,
    generated_for_date DATE                  NULL
);
DELIMITER $$

DROP PROCEDURE IF EXISTS financial21_99.generate_cards_at_expiration_report;
CREATE PROCEDURE financial21_99.generate_cards_at_expiration_report(p_date DATE)
BEGIN
    TRUNCATE TABLE financial21_99.cards_at_expiration;

    INSERT INTO financial21_99.cards_at_expiration
    WITH cte AS (
        SELECT
            c2.client_id,
            c.card_id,
            DATE_ADD(c.issued, INTERVAL 3 YEAR) AS expiration_date,
            d2.A3 AS client_address
        FROM
            financial21_99.card AS c
        INNER JOIN
            financial21_99.disp AS d USING (disp_id)
        INNER JOIN
            financial21_99.client AS c2 USING (client_id)
        INNER JOIN
            financial21_99.district AS d2 USING (district_id)
    )
    SELECT
        *,
        p_date
    FROM cte
    WHERE p_date BETWEEN DATE_ADD(expiration_date, INTERVAL -7 DAY) AND expiration_date;

END$$

DELIMITER ;

CALL financial21_99.generate_cards_at_expiration_report('2001-01-01');
SELECT * FROM financial21_99.cards_at_expiration;

