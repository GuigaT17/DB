
SELECT NIF, nome, genero, nAulas2 as nAulas, ano
  FROM (SELECT ano3 as ano2, genero3 as genero2, MAX(cAulas) as nAulas2
          FROM (SELECT U.nif, U.genero as genero3, COUNT (F.aula) as cAulas, TO_CHAR(F.data, 'YYYY') as ano3
                  FROM utente U, frequenta F
                 WHERE (U.nif = F.utente)
                   AND (U.genero = 'F')
                GROUP BY (U.nif, U.genero, TO_CHAR (F.data, 'YYYY'))
                 UNION
                SELECT U.nif, U.genero as genero3, COUNT (F.aula) as cAulas, TO_CHAR(F.data, 'YYYY') as ano3
                  FROM utente U, frequenta F
                 WHERE (U.nif = F.utente)
                   AND (U.genero = 'M')
                GROUP BY (U.nif, U.genero, TO_CHAR (F.data, 'YYYY')))
        GROUP BY ano3, genero3) maxPorAno,
        (SELECT U.nif, U.nome, U.genero as genero, COUNT (F.aula) as cAulas, TO_CHAR(F.data, 'YYYY') as ano
           FROM utente U, frequenta F
          WHERE (U.nif = F.utente)
            AND (U.genero = 'F')
       GROUP BY (U.nif, U.nome, U.genero, TO_CHAR (F.data, 'YYYY'))
          UNION
         SELECT U.nif, U.nome, U.genero , COUNT (F.aula), TO_CHAR(F.data, 'YYYY')
           FROM utente U, frequenta F
          WHERE (U.nif = F.utente)
            AND (U.genero = 'M')
         GROUP BY (U.nif, U.nome, U.genero, TO_CHAR (F.data, 'YYYY'))) aulasUtentes
 WHERE (maxPorAno.ano2 = aulasUtentes.ano)
   AND (maxPorAno.genero2 = aulasUtentes.genero)
   AND (maxPorAno.nAulas2 = aulasUtentes.cAulas)
ORDER BY ano DESC, genero ASC, NIF ASC, nome ASC;

--tambem esta certo
SELECT NIF, nome, genero, nAulas2 as nAulas, ano
  FROM (SELECT ano3 as ano2, genero3 as genero2, MAX(cAulas) as nAulas2
          FROM (SELECT U.nif, U.genero as genero3, COUNT (F.aula) as cAulas, TO_CHAR(F.data, 'YYYY') as ano3
                  FROM utente U, frequenta F
                 WHERE (U.nif = F.utente)
                   AND (U.genero = 'F')
                GROUP BY (U.nif, U.genero, TO_CHAR (F.data, 'YYYY'))
                 UNION
                SELECT U.nif, U.genero as genero3, COUNT (F.aula) as cAulas, TO_CHAR(F.data, 'YYYY') as ano3
                  FROM utente U, frequenta F
                 WHERE (U.nif = F.utente)
                   AND (U.genero = 'M')
                GROUP BY (U.nif, U.genero, TO_CHAR (F.data, 'YYYY')))
        GROUP BY ano3, genero3) maxPorAno,
        (SELECT U.nif, U.nome, U.genero as genero, COUNT (F.aula) as cAulas, TO_CHAR(F.data, 'YYYY') as ano
           FROM utente U, frequenta F
          WHERE (U.nif = F.utente)
        GROUP BY U.nif, U.nome, U.genero, TO_CHAR(F.data, 'YYYY')) aulasUtentes
 WHERE (maxPorAno.ano2 = aulasUtentes.ano)
   AND (maxPorAno.genero2 = aulasUtentes.genero)
   AND (maxPorAno.nAulas2 = aulasUtentes.cAulas)
ORDER BY ano DESC, genero ASC, NIF ASC, nome ASC;

/*
(SELECT ano3 as ano2, genero3 as genero2, MAX(cAulas) as nAulas2
  FROM (SELECT U.nif, U.nome, U.genero as genero3, COUNT (F.aula) as cAulas, TO_CHAR(F.data, 'YYYY') as ano3
          FROM utente U, frequenta F
         WHERE (U.nif = F.utente)
           AND (U.genero = 'F')
        GROUP BY (U.nif, U.nome, U.genero, TO_CHAR (F.data, 'YYYY'))
         UNION
        SELECT U.nif, U.nome, U.genero as genero3, COUNT (F.aula) as cAulas, TO_CHAR(F.data, 'YYYY') as ano3
          FROM utente U, frequenta F
         WHERE (U.nif = F.utente)
           AND (U.genero = 'M')
        GROUP BY (U.nif, U.nome, U.genero, TO_CHAR (F.data, 'YYYY')))
 GROUP BY ano3, genero3) maxPorAno,

 (SELECT U.nif, U.nome, U.genero as genero3, COUNT (F.aula) as cAulas, TO_CHAR(F.data, 'YYYY') as ano3
         FROM utente U, frequenta F
        WHERE (U.nif = F.utente)
          AND (U.genero = 'F')
       GROUP BY (U.nif, U.nome, U.genero, TO_CHAR (F.data, 'YYYY'))
        UNION
       SELECT U.nif, U.nome, U.genero as genero3, COUNT (F.aula) as cAulas, TO_CHAR(F.data, 'YYYY') as ano3
         FROM utente U, frequenta F
        WHERE (U.nif = F.utente)
          AND (U.genero = 'M')
       GROUP BY (U.nif, U.nome, U.genero, TO_CHAR (F.data, 'YYYY'))) aulasUtentes,
*/

COMMIT;
