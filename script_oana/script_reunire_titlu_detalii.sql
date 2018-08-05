UPDATE autor
SET titlu = concat(titlu, " ", detalii), detalii = NULL
WHERE detalii is not NULL;

SELECT * FROM autor WHERE titlu IS NOT NULL OR detalii IS NOT NULL;

ALTER TABLE autor DROP COLUMN detalii;