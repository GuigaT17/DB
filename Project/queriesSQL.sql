SELECT DISTINCT U.nif, U.nome, A.modalidade, TO_CHAR(F.data, 'DD.MM.YYYY') as data
  FROM utente U, frequenta F, aula A
 WHERE U.nif = F.utente
   AND A.id = F.aula
   AND F.data BETWEEN TO_DATE('01-01-2017', 'DD.MM.YYYY') AND TO_DATE('31-12-2017', 'DD.MM.YYYY')
   ORDER BY A.modalidade, U.nome, U.nif ASC, data;

--------------------------------------------------------------------------------
SELECT A1.espaco, A1.modalidade
  FROM aula A1
 WHERE (A1.dia_semana = 'SUN')
   AND (SELECT COUNT (F.aula)
          FROM frequenta F
         WHERE F.aula = A1.id) > 0
 UNION
SELECT A2.espaco, A2.modalidade
  FROM aula A2, utente U, frequenta F
 WHERE (U.genero = 'M')
   AND (U.ano >= 2001)
   AND (F.utente = U.nif)
   AND (F.aula = A2.id);


--------------------------------------------------------------------------------
SELECT DISTINCT A.dia_semana, A.hora_inicio, A.hora_fim, A.espaco, A.modalidade
  FROM aula A, frequenta F, utente U
  WHERE (A.hora_inicio BETWEEN 12 AND 20 OR A.hora_fim BETWEEN 12 AND 20)
  AND (F.aula = A.id)
  AND (TO_CHAR(F.data, 'MM.YYYY') = '01.2018')
  AND (U.nome LIKE 'C%')
  AND (U.ano BETWEEN 1973 AND 2001);

--------------------------------------------------------------------------------
SELECT U.nif, U.nome, (extract(year from sysdate) - U.ano) AS idade
  FROM utente U
 WHERE (NOT EXISTS (SELECT A.modalidade
                      FROM aula A, frequenta F
                     WHERE A.id = F.aula
                       AND U.nif = F.utente
                       AND A.hora_inicio < 12
                       AND A.modalidade = 'ginastica'));

--------------------------------------------------------------------------------
SELECT DISTINCT A.modalidade, A.espaco, A.dia_semana, A.hora_inicio
  FROM aula A, frequenta F, utente U
 WHERE (U.ano = (SELECT ano
                   FROM (SELECT U2.ano as ano
                           FROM utente U2
                           GROUP BY U2.ano
                           ORDER BY count(U2.ano) DESC, U2.ano DESC)
                   WHERE ROWNUM <= 1))
  AND (F.utente = U.nif)
  AND (F.aula = A.id)
  AND (U.genero = 'F')
ORDER BY dia_semana, hora_inicio, modalidade ASC;

--------------------------------------------------------------------------------
SELECT U.nif, U.nome, A.modalidade, TO_CHAR(F.data, 'YYYY') AS ano, ((COUNT(U.ano))*10*1.23) AS total_euros
 FROM utente U, aula A, frequenta F
WHERE (F.utente = U.nif)
  AND (F.aula = A.id)
GROUP BY U.nif, U.nome, A.modalidade, TO_CHAR(F.data, 'YYYY')
ORDER BY U.nif, A.modalidade ASC, ano DESC;

--------------------------------------------------------------------------------
SELECT nif, nome, sum(cHoras) AS horas, ano
FROM (SELECT U.nif as nif, U.nome as nome, NVL((A.hora_fim - A.hora_inicio),0) as cHoras, TO_CHAR(F.data, 'YYYY') AS ano
        FROM utente U LEFT OUTER JOIN frequenta F ON (F.utente = U.nif) LEFT OUTER JOIN aula A ON (F.aula = A.id))
GROUP BY nif, nome, ano
ORDER BY horas DESC, nif, nome ASC;

--------------------------------------------------------------------------------
SELECT nif, nome, genero, n_Aulas, ano
  FROM (SELECT ano2 as ano, genero2 as genero, MAX(cAulas) as n_Aulas
          FROM (SELECT U.nif, U.genero as genero2, COUNT (F.aula) as cAulas, TO_CHAR(F.data, 'YYYY') as ano2
                  FROM utente U, frequenta F
                 WHERE (U.nif = F.utente)
                GROUP BY (U.nif, U.genero, TO_CHAR (F.data, 'YYYY')))
        GROUP BY ano2, genero2) maxPorAno,
        (SELECT U.nif, U.nome, U.genero as genero3, COUNT (F.aula) as cAulas, TO_CHAR(F.data, 'YYYY') as ano4
           FROM utente U, frequenta F
          WHERE (U.nif = F.utente)
        GROUP BY U.nif, U.nome, U.genero, TO_CHAR(F.data, 'YYYY')) aulasUtentes
 WHERE (maxPorAno.ano = aulasUtentes.ano4)
   AND (maxPorAno.genero = aulasUtentes.genero3)
   AND (maxPorAno.n_Aulas = aulasUtentes.cAulas)
ORDER BY ano DESC, genero, NIF, nome ASC;

-- -----------------------------------------------------------------------------

COMMIT;
