# eliminare duplicati din autor

create temporary table tmpTable (id int, nume VARCHAR(30), prenume VARCHAR(30));

insert  tmpTable
        (id, nume, prenume)
select  yt.id, yt.nume, yt.prenume
from    autor yt
where   exists
        (
        select  *
        from    autor yt2
        where   yt2.nume = yt.nume
                and yt2.prenume = yt.prenume
                and yt2.id > yt.id
        );

create temporary table tmpTable2 (id int, nume VARCHAR(30), prenume VARCHAR(30));

insert  tmpTable2
        (id, nume, prenume)
select  yt.id, yt.nume, yt.prenume
from    autor yt
where   exists
        (
        select  *
        from    tmpTable yt2
        where   yt2.nume = yt.nume
                and yt2.prenume = yt.prenume
                and yt2.id <> yt.id
        );


create temporary table originaliiDuplicati (id int, nume VARCHAR(30), prenume VARCHAR(30));

insert  originaliiDuplicati
        (id, nume, prenume)
SELECT id, nume, prenume FROM autor where id not in (SELECT id from tmpTable) and id in (SELECT id from tmpTable2);


create temporary table Inlocuiri (id int, nume VARCHAR(30), prenume VARCHAR(30), idreplace int);

insert Inlocuiri (id, nume, prenume, idreplace)
SELECT tmp.id, tmp.nume, tmp.prenume, ori.id FROM tmpTable tmp, OriginaliiDuplicati ori
WHERE tmp.nume = ori.nume AND tmp.prenume = ori.prenume;


# trying to replace copy with original

UPDATE autorlistatraduceri, Inlocuiri
SET autorlistatraduceri.autorId = Inlocuiri.idreplace
WHERE autorlistatraduceri.autorId = Inlocuiri.id;

UPDATE bibliografieautor, Inlocuiri
SET bibliografieautor.autorId = Inlocuiri.idreplace
WHERE bibliografieautor.autorId = Inlocuiri.id;

DELETE FROM autor WHERE id in (SELECT id FROM tmpTable);

  
drop table Inlocuiri;
drop table originaliiDuplicati;
drop table tmpTable2;
drop table tmpTable;