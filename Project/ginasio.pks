CREATE OR REPLACE PACKAGE ginasio IS

  -- Todas as operacoes lançam excecoes para sinalizar casos de erro.
  --
  -- Exceção Mensagem
  --  -20001 Ja existe um utente com esse numero.
  --  -20002 Aula ja existe no mesmo horario e local.
  --  -20003 Ja existe uma aula com esse numero.
  --  -20004 Aula ja esta lotada.
  --  -20005 O dia da semana nao corresponde com o da aula.
  --  -20006 Utente a remover nao existe.
  --  -20007 Aula a remover nao existe.
  --  -20008 Frequencia a remover nao existe.

  -- Cria um novo registo do utente.
  PROCEDURE regista_utente (
    nif_in             IN utente.nif%TYPE,
    nome_in            IN utente.nome%TYPE,
    genero_in          IN utente.genero%TYPE,
    ano_nascimento_in  IN utente.ano%TYPE);

  -- Cria um novo registo da aula.
  FUNCTION regista_aula (
    modalidade_in      IN aula.modalidade%TYPE,
    espaco_in          IN aula.espaco%TYPE,
    dia_semana_in      IN aula.dia_semana%TYPE,
    hora_inicio_in     IN aula.hora_inicio%TYPE,
    hora_fim_in        IN aula.hora_fim%TYPE)
    RETURN aula.id%TYPE;

 -- Cria um novo registo da frequencia das aulas.
  PROCEDURE regista_frequencia_aula (
    utente_in          IN frequenta.utente%TYPE,
    aula_in            IN frequenta.aula%TYPE,
    data_in            IN frequenta.data%TYPE);

 -- Cria uma lista das aulas frequentadas pelo utente durante um mês.
  FUNCTION lista_aulas_frequentadas (
    utente_in          IN frequenta.utente%TYPE,
    data_in            IN DATE)
    RETURN SYS_REFCURSOR;

  -- Remove um utente ja existente.
  PROCEDURE remove_utente (
    nif_in             IN utente.nif%TYPE);

  -- Remove uma aula ja existente.
  PROCEDURE remove_aula (
    aula_in           IN aula.id%TYPE);

  -- Remove a frequencia de uma aula ja existente.
  PROCEDURE remove_frequencia_aula (
    utente_in         IN frequenta.utente%TYPE,
    aula_in           IN frequenta.aula%TYPE,
    data_in           IN frequenta.data%TYPE);

END ginasio;
/
