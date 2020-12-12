--variaveis de aula
VARIABLE id_aula_1 NUMBER;
VARIABLE id_aula_2 NUMBER;
VARIABLE id_aula_3 NUMBER;
VARIABLE id_aula_4 NUMBER;
VARIABLE id_aula_5 NUMBER;
VARIABLE id_aula_6 NUMBER;
VARIABLE id_aula_7 NUMBER;
VARIABLE id_aula_8 NUMBER;
--------------------REGISTA UTENTE------------------------------
BEGIN
ginasio.regista_utente(123456789, 'Joao', 'M', 1999);
ginasio.regista_utente(234567891, 'Maria', 'F', 1999);
ginasio.regista_utente(345678912, 'Pedro', 'M', 1997);
ginasio.regista_utente(456789123, 'Ines', 'F', 1997);
ginasio.regista_utente(567891234, 'Ruhan', 'M', 1995);
ginasio.regista_utente(678912345, 'Leonor', 'F', 1994);
ginasio.regista_utente(789123456, 'Gabriel', 'M', 1993);
ginasio.regista_utente(891234567, 'Beatriz', 'F', 1992);
ginasio.regista_utente(912345678, 'Carlos', 'M', 1991);
ginasio.regista_utente(987654321, 'Teresa', 'F', 1990);
ginasio.regista_utente(147258369, 'Guilherme', 'M', 1989);
ginasio.regista_utente(555555555, 'Ismael', 'M', 1989);
ginasio.regista_utente(666666666, 'Jose', 'M', 2009);
--
END;
/


BEGIN
--testar que o nif eh unico
ginasio.regista_utente(123456789, 'Miguel', 'M', 1998);
END;
/
-------------------------REGISTA AULA------------------------------------------------
BEGIN
:id_aula_1 := ginasio.regista_aula('Jiu-jitsu', 'espaco01', 'MON', 10, 12);
:id_aula_2 := ginasio.regista_aula('Jiu-jitsu', 'espaco02', 'TUE', 19, 20);
:id_aula_3 := ginasio.regista_aula('Karate', 'espaco03', 'WED', 19, 20);
:id_aula_4 := ginasio.regista_aula('Jiu-jitsu', 'espaco01', 'MON', 18, 19);
:id_aula_5 := ginasio.regista_aula('Jiu-jitsu', 'espaco01', 'MON', 16, 17);
:id_aula_6 := ginasio.regista_aula('Yoga', 'espaco04', 'SUN', 16, 17);
:id_aula_7 := ginasio.regista_aula('Crossfit', 'espaco05', 'FRI', 10, 11);
END;
/

BEGIN
--testar que o espaco esta reservado para um dado horario
:id_aula_8 := ginasio.regista_aula('kung-fu', 'espaco02', 'TUE', 19, 20);
END;
/


BEGIN
--lotar a aula 1 de jiu jitsu em 10-12-2018 (segunda)
ginasio.regista_frequencia_aula(123456789, :id_aula_1, TO_DATE('10-12-2018', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(234567891, :id_aula_1, TO_DATE('10-12-2018', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(345678912, :id_aula_1, TO_DATE('10-12-2018', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(456789123, :id_aula_1, TO_DATE('10-12-2018', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(567891234, :id_aula_1, TO_DATE('10-12-2018', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(678912345, :id_aula_1, TO_DATE('10-12-2018', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(789123456, :id_aula_1, TO_DATE('10-12-2018', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(891234567, :id_aula_1, TO_DATE('10-12-2018', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(912345678, :id_aula_1, TO_DATE('10-12-2018', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(987654321, :id_aula_1, TO_DATE('10-12-2018', 'DD.MM.YYYY'));

--meter alguns alunos a praticar jiu-jitsu em 5-12-2017 (segunda)
ginasio.regista_frequencia_aula(345678912, :id_aula_2, TO_DATE('05-12-2017', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(456789123, :id_aula_2, TO_DATE('05-12-2017', 'DD.MM.YYYY'));

--meter alguns alunos a pratcar karate a 12-12-2018 (quarta)
ginasio.regista_frequencia_aula(567891234, :id_aula_3, TO_DATE('12-12-2018', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(678912345, :id_aula_3, TO_DATE('12-12-2018', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(345678912, :id_aula_3, TO_DATE('12-12-2018', 'DD.MM.YYYY'));

--meter o joao e a maria a ter uma aula de jiu jitsu extra a 10-12-2018 (segunda)
ginasio.regista_frequencia_aula(123456789, :id_aula_4, TO_DATE('10-12-2018', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(234567891, :id_aula_4, TO_DATE('10-12-2018', 'DD.MM.YYYY'));
ginasio.regista_frequencia_aula(345678912, :id_aula_4, TO_DATE('10-12-2018', 'DD.MM.YYYY'));

--meter o joao a ter jiu jitsu no dia  5-12-2017 (terça)
ginasio.regista_frequencia_aula(123456789, :id_aula_2, TO_DATE('05-12-2017', 'DD.MM.YYYY'));

--meter o joao a ter jiu jitsu no dia 11-12-2017 (segunda)
ginasio.regista_frequencia_aula(123456789, :id_aula_5, TO_DATE('11-12-2017', 'DD.MM.YYYY'));

--meter o joao a ter karate no dia 12-12-2018 (quarta)
ginasio.regista_frequencia_aula(123456789, :id_aula_3, TO_DATE('12-12-2018', 'DD.MM.YYYY'));

--joao tem no domingo
ginasio.regista_frequencia_aula(123456789, :id_aula_6, TO_DATE('16-12-2018', 'DD.MM.YYYY'));

ginasio.regista_frequencia_aula(666666666, :id_aula_2, TO_DATE('05-12-2017', 'DD.MM.YYYY'));

--carlos tem aula sexual em janeiro
ginasio.regista_frequencia_aula(912345678, :id_aula_7, TO_DATE('05-01-2018', 'DD.MM.YYYY'));
END;
/


BEGIN
--tentar lotar aula 1
ginasio.regista_frequencia_aula(147258369, :id_aula_1, TO_DATE('10-12-2018', 'DD.MM.YYYY'));
END;
/


BEGIN
--tentar inscrever com uma data errada
ginasio.regista_frequencia_aula(147258369, :id_aula_2, TO_DATE('05-12-2018', 'DD.MM.YYYY'));
END;
/


BEGIN
ginasio.remove_utente(555555555);
END;
/


BEGIN
--remover um utente que nao existe
ginasio.remove_utente(963852741);
END;
/


BEGIN
ginasio.remove_aula(:id_aula_1);
END;
/


BEGIN
--remover aula que nao existe
ginasio.remove_aula(8);
END;
/


BEGIN
ginasio.remove_frequencia_aula(345678912, :id_aula_2, TO_DATE('05-12-2018', 'DD.MM.YYYY'));
END;
/


BEGIN
  --frequencia a remover nao existe
ginasio.remove_frequencia_aula(345678912, :id_aula_3, TO_DATE('12-12-2018', 'DD.MM.YYYY'));
END;
/
