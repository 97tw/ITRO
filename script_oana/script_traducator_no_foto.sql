#update at traducator where foto is null

UPDATE traducator
SET foto = NULL
WHERE foto LIKE '%nu%' OR foto LIKE '%Nu%' OR foto LIKE '%nU%' OR foto LIKE '%NU%';