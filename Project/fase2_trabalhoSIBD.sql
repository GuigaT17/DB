-- ----------------------------------------------------------------------------
DROP SEQUENCE seq_regista_aula_id;
DROP TABLE frequenta;
DROP TABLE aula;
DROP TABLE utente;
-- ----------------------------------------------------------------------------
CREATE TABLE utente
 (
  nif        NUMBER(9),
  nome       VARCHAR2(80) CONSTRAINT nn_utente_nomes   NOT NULL,
  genero     CHAR(1)      CONSTRAINT nn_utente_generos NOT NULL,
  ano        NUMBER(4)    CONSTRAINT nn_utente_anos   NOT NULL,
--
  CONSTRAINT pk_utente
    PRIMARY KEY (nif),
--
  CONSTRAINT ck_utente_nif
    CHECK (nif BETWEEN 1 AND 999999999),
--
  CONSTRAINT ck_utente_generos
    CHECK (genero IN ('F', 'M')),
--
  CONSTRAINT ck_utente_anos
-- Ano de nascimento do utente.
    CHECK (ano BETWEEN 1900 AND 2100)
);
-- ----------------------------------------------------------------------------
CREATE TABLE aula
 (
  id          NUMBER(4),
-- Para referenciação mais simples.
  modalidade  VARCHAR2(40) CONSTRAINT nn_aula_modalidade  NOT NULL,
  espaco      VARCHAR2(40) CONSTRAINT nn_aula_espaco      NOT NULL,
  dia_semana  CHAR(3)      CONSTRAINT nn_aula_dia_semana  NOT NULL,
  hora_inicio NUMBER(2)    CONSTRAINT nn_aula_hora_inicio NOT NULL,
  hora_fim    NUMBER(2)    CONSTRAINT nn_aula_hora_fim    NOT NULL,
--
  CONSTRAINT pk_aula
    PRIMARY KEY (id),
--
  CONSTRAINT un_aula_espaco_tempo   -- Chave candidata.
    UNIQUE (espaco, dia_semana, hora_inicio, hora_fim),
--
  CONSTRAINT ck_aula_id
    CHECK (id BETWEEN 1 AND 9999),
--
  CONSTRAINT ck_aula_dia_semana
-- Pode ser preciso adaptar a outro idioma.
    CHECK (dia_semana IN ('SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT')),
--
  CONSTRAINT ck_aula_hora_inicio
    CHECK (hora_inicio BETWEEN 0 AND 23),
--
  CONSTRAINT ck_aula_hora_fim
    CHECK (hora_fim BETWEEN 1 AND 24),
--
  CONSTRAINT ck_aula_inicio_fim
    CHECK (hora_inicio < hora_fim)
);

CREATE SEQUENCE seq_regista_aula_id
  INCREMENT BY 1 MAXVALUE 999999 NOCYCLE;
-- ----------------------------------------------------------------------------
CREATE TABLE frequenta
 (
  utente,
  aula,
  data    DATE,
--
  CONSTRAINT pk_frequenta
    PRIMARY KEY (utente, aula, data),
--
  CONSTRAINT fk_frequenta_utente
    FOREIGN KEY (utente)
    REFERENCES utente (nif),
--
  CONSTRAINT fk_frequenta_aula
    FOREIGN KEY (aula)
    REFERENCES aula (id),
--
  CONSTRAINT ck_frequenta_data
    CHECK (TO_CHAR(data, 'YYYY') BETWEEN 1900 AND 2100)
-- A conversão do ano para número é implícita.
);
-- ----------------------------------------------------------------------------
COMMIT;
