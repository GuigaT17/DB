CREATE OR REPLACE PACKAGE BODY ginasio IS

  -- --------------------------------------------------------------------------
  --Cria um novo registo de um utente.
  PROCEDURE regista_utente (
    nif_in              IN utente.nif%TYPE,
    nome_in             IN utente.nome%TYPE,
    genero_in           IN utente.genero%TYPE,
    ano_nascimento_in   IN utente.ano%TYPE)
  IS
  BEGIN
    INSERT INTO utente (nif, nome, genero, ano)
         VALUES (nif_in, nome_in, genero_in, ano_nascimento_in);

  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20001, 'Ja existe um utente ' ||
                                         'com esse numero.');
  END regista_utente;

  -- --------------------------------------------------------------------------
  --Regista uma nova aula e retorna o seu id se foi adicionada.
  FUNCTION regista_aula (
    modalidade_in      IN aula.modalidade%TYPE,
    espaco_in          IN aula.espaco%TYPE,
    dia_semana_in      IN aula.dia_semana%TYPE,
    hora_inicio_in     IN aula.hora_inicio%TYPE,
    hora_fim_in        IN aula.hora_fim%TYPE)
    RETURN aula.id%TYPE
  IS
    new_id aula.id%TYPE := seq_regista_aula_id.NEXTVAL;
    contaAulas NUMBER;
  BEGIN
  SELECT COUNT(*) INTO contaAulas
         FROM aula A
         WHERE A.espaco = espaco_in
         AND A.dia_semana = dia_semana_in
         AND hora_inicio_in BETWEEN A.hora_inicio AND A.hora_fim
         AND hora_fim_in BETWEEN A.hora_inicio AND A.hora_fim;
    IF (contaAulas > 0)
      THEN RAISE_APPLICATION_ERROR(-20002, 'Aula ja existe no mesmo horario e local');
    ELSE
      INSERT INTO aula (id, modalidade, espaco, dia_semana, hora_inicio, hora_fim)
        VALUES (new_id, modalidade_in, espaco_in, dia_semana_in, hora_inicio_in, hora_fim_in);
    RETURN new_id;
    END IF;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
         RAISE_APPLICATION_ERROR(-20003, 'Ja existe uma aula ' ||
                                         'com esse numero.');
    WHEN OTHERS THEN RAISE;
   END regista_aula;
  -- --------------------------------------------------------------------------
  --Inscreve um utente num aula
  PROCEDURE regista_frequencia_aula (
    utente_in         IN frequenta.utente%TYPE,
    aula_in            IN frequenta.aula%TYPE,
    data_in            IN	frequenta.data%TYPE)
  IS
    lotacao NUMBER;
    diaAula aula.dia_semana%TYPE;
  BEGIN
  SELECT COUNT (*) INTO lotacao
         FROM frequenta F
         WHERE F.aula = aula_in;
  SELECT A.dia_semana INTO diaAula
         FROM aula A
         WHERE A.id = aula_in;
    IF (lotacao >= 10)
       THEN RAISE_APPLICATION_ERROR(-20004, 'Aula ja esta lotada');
    ELSIF (TO_CHAR (data_in, 'DY') <> diaAula)
       THEN RAISE_APPLICATION_ERROR(-20005, 'O dia de semana nao corresponde com o da aula');
    ELSE
       INSERT INTO frequenta(utente, aula, data)
         VALUES (utente_in, aula_in, data_in);
    END IF;
  EXCEPTION
    WHEN OTHERS THEN RAISE;
  END regista_frequencia_aula;
  -- --------------------------------------------------------------------------
  --Retorna um cursor com a lista de aulas frequentadas por um utente
  FUNCTION lista_aulas_frequentadas (
    utente_in       IN frequenta.utente%TYPE,
    data_in          IN DATE)
    RETURN SYS_REFCURSOR
  IS
  cursor_aulas SYS_REFCURSOR;
  BEGIN
  OPEN cursor_aulas FOR
  -- DUVIDA tirar o data_in do cursor
   SELECT F1.data, A.dia_semana, A.hora_inicio, A.hora_fim, A.espaco, A.modalidade
     FROM aula A, frequenta F1
     WHERE (F1.aula = A.id)
     AND (A.id IN (SELECT F2.aula
                      FROM frequenta F2
                     WHERE (F2.utente = utente_in)
                       AND to_char(F2.data, 'MON-YY') = to_char(data_in, 'MON-YY')));
  RETURN cursor_aulas;
  EXCEPTION
    WHEN OTHERS THEN RAISE;
  END lista_aulas_frequentadas;
  -- ---------------------------------------------------------------------------
  --Remove um utente ja existente.
  PROCEDURE remove_utente (
    nif_in             IN utente.nif%TYPE)
  IS
  BEGIN
    DELETE FROM frequenta WHERE (utente = nif_in);
    DELETE FROM utente WHERE (nif = nif_in);
    IF (SQL%ROWCOUNT = 0) THEN
      RAISE_APPLICATION_ERROR(-20006, 'Utente a remover nao existe.');
    END IF;

  EXCEPTION
    WHEN OTHERS THEN RAISE;
  END remove_utente;
-- -----------------------------------------------------------------------------
--Remove uma aula ja existente.
PROCEDURE remove_aula (
    aula_in             IN aula.id%TYPE)
IS
BEGIN
  DELETE FROM frequenta WHERE (aula = aula_in);
  DELETE FROM aula WHERE (aula_in = aula.id);
  IF (SQL%ROWCOUNT = 0) THEN
    RAISE_APPLICATION_ERROR(-20007, 'Aula a remover nao existe.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN RAISE;
END remove_aula;
-- -----------------------------------------------------------------------------
--Remove a frequencia de uma aula ja existente.
PROCEDURE remove_frequencia_aula (
    utente_in          IN frequenta.utente%TYPE,
    aula_in            IN frequenta.aula%TYPE,
    data_in            IN frequenta.data%TYPE)
IS
BEGIN
  DELETE FROM frequenta WHERE (utente = utente_in)
                          AND (aula = aula_in)
                          AND (data = data_in);
      IF (SQL%ROWCOUNT = 0)
      THEN
      --Nenhuma linha foi afetada pelo comando DELETE.
      RAISE_APPLICATION_ERROR(-20008, 'Frequencia a remover nao existe.');
      END IF;
EXCEPTION
  WHEN OTHERS THEN RAISE;
END remove_frequencia_aula;
-- ----------------------------------------------------------------------------
END ginasio;
/
