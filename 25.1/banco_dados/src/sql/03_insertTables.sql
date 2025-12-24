INSERT INTO plano (nome_plano, valor_plano, duracao_meses_plano, descricao_plano) VALUES
('Plano Mensal', 129.90, 1, 'Acesso completo a todas as áreas da academia por 1 mês.'),
('Plano Semestral', 659.40, 6, 'Acesso completo por 6 meses com desconto.'),
('Plano Anual Fidelidade', 1188.00, 12, 'O melhor custo-benefício. Acesso completo por 12 meses.');

-- 1.2 Inserindo Instrutores
INSERT INTO instrutor (nome_instrutor, telefone_instrutor, email_instrutor, cref_instrutor, especializacao_instrutor) VALUES
('Carlos Souza', '48999887766', 'carlos.souza@gym.com', '012345-G/SC', 'Musculação e Treinamento Funcional'),
('Mariana Lima', '48988776655', 'mariana.lima@gym.com', '543210-G/SC', 'Yoga e Pilates'),
('Fernanda Costa', '48977665544', 'fernanda.costa@gym.com', '112233-G/SC', 'Spinning e Aulas Aeróbicas'),
('Ricardo Oliveira', '48966554433', 'ricardo.oliveira@gym.com', '445566-G/SC', 'Avaliação Física e Reabilitação'),
('Lucas Ferreira', '48955443322', 'lucas.ferreira@gym.com', '778899-G/SC', 'Musculação e Hipertrofia'),
('Juliana Paes', '48944332211', 'juliana.paes@gym.com', '101010-G/SC', 'Musculação e Definição'),
('Beto Carvalho', '48933221100', 'beto.carvalho@gym.com', '202020-G/SC', 'Musculação e Powerlifting'),
('Vanessa Alves', '48922110099', 'vanessa.alves@gym.com', '303030-G/SC', 'Treinamento Funcional e HIIT'),
('Diogo Mello', '48911009988', 'diogo.mello@gym.com', '404040-G/SC', 'Musculação Avançada'),
('Sandra Marques', '48900998877', 'sandra.marques@gym.com', '505050-G/SC', 'Musculação para Terceira Idade');

-- 1.3 Inserindo Salas
INSERT INTO sala (nome_sala, descricao_sala, capacidade_sala) VALUES
('Área de Musculação', 'Piso principal com todos os equipamentos de musculação.', 50),
('Sala de Spinning', 'Sala climatizada com 20 bicicletas de spinning.', 20),
('Sala Multiuso', 'Sala para aulas de funcional, yoga e outras modalidades em grupo.', 25),
('Área de Cardio', 'Área com esteiras, elípticos e bicicletas.', 30);

-- 1.4 Inserindo Modalidades
INSERT INTO modalidade (nome_modalidade, descricao_modalidade) VALUES
('Musculação', 'Treinamento com pesos para fortalecimento e hipertrofia.'),
('Spinning', 'Aula de ciclismo indoor de alta intensidade.'),
('Yoga', 'Prática de posturas e meditação para corpo e mente.'),
('Treinamento Funcional', 'Treino baseado nos movimentos naturais do corpo.'),
('Pilates', 'Método de controle muscular para força e flexibilidade.');

-- 1.5 Inserindo Tipos de Medida para Avaliação
INSERT INTO tipo_medida (nome_medida, unidade_medida) VALUES
('Peso Corporal', 'kg'), ('Altura', 'm'), ('Percentual de Gordura', '%'),
('Massa Muscular Esquelética', 'kg'), ('Circunferência do Abdômen', 'cm'),
('Flexibilidade (Teste de Sentar e Alcançar)', 'cm'), ('IMC', 'kg/m²'), ('Pressão Arterial', 'mmHg');

-- 1.6 Inserindo Exercícios
INSERT INTO exercicio (nome_exercicio, grupo_muscular) VALUES
('Supino Reto com Barra', 'Peitoral'), ('Supino Inclinado com Halteres', 'Peitoral'), ('Supino Declinado', 'Peitoral'), ('Crucifixo com Halteres', 'Peitoral'), ('Voador (Pec Deck)', 'Peitoral'), ('Flexão de Braço', 'Peitoral'), ('Puxada Frontal (Pulley)', 'Costas'), ('Remada Curvada com Barra', 'Costas'), ('Remada Unilateral (Serrote)', 'Costas'), ('Remada Cavalinho', 'Costas'), ('Barra Fixa', 'Costas'), ('Pulldown com Corda', 'Costas'), ('Levantamento Terra', 'Costas/Pernas'), ('Desenvolvimento com Halteres', 'Ombros'), ('Desenvolvimento Militar com Barra', 'Ombros'), ('Elevação Lateral', 'Ombros'), ('Elevação Frontal', 'Ombros'), ('Remada Alta', 'Ombros'), ('Crucifixo Invertido', 'Ombros'), ('Rosca Direta com Barra', 'Bíceps'), ('Rosca Alternada com Halteres', 'Bíceps'), ('Rosca Martelo', 'Bíceps'), ('Rosca Scott', 'Bíceps'), ('Rosca Concentrada', 'Bíceps'), ('Tríceps Pulley com Barra', 'Tríceps'), ('Tríceps Testa com Barra', 'Tríceps'), ('Tríceps Francês Unilateral', 'Tríceps'), ('Mergulho no Banco', 'Tríceps'), ('Tríceps Coice', 'Tríceps'), ('Agachamento Livre', 'Pernas'), ('Leg Press 45', 'Pernas'), ('Cadeira Extensora', 'Pernas'), ('Agachamento Hack', 'Pernas'), ('Avanço (Passada)', 'Pernas'), ('Mesa Flexora', 'Pernas'), ('Cadeira Flexora', 'Pernas'), ('Stiff com Barra', 'Pernas'), ('Elevação Pélvica (Hip Thrust)', 'Glúteos'), ('Cadeira Abdutora', 'Glúteos'), ('Cadeira Adutora', 'Pernas'), ('Panturrilha em Pé (Gêmeos)', 'Pernas'), ('Panturrilha Sentado (Sóleo)', 'Pernas'), ('Abdominal Supra', 'Abdômen'), ('Abdominal Infra (Elevação de Pernas)', 'Abdômen'), ('Prancha Isométrica', 'Abdômen'), ('Abdominal Oblíquo (Giro Russo)', 'Abdômen'), ('Abdominal na Roda', 'Abdômen'), ('Corrida na Esteira', 'Cardio'), ('Bicicleta Ergométrica', 'Cardio'), ('Elíptico (Transport)', 'Cardio'), ('Remo Indoor', 'Cardio'), ('Escada (Stair Master)', 'Cardio'), ('Pular Corda', 'Cardio');

-- 1.7 Inserindo Alunos
INSERT INTO aluno (nome_aluno, cpf_aluno, data_nascimento_aluno, telefone_aluno, email_aluno, endereco_aluno, data_matricula_aluno) VALUES
('Ana Silva', '11122233344', '1995-05-10', '48911112222', 'ana.silva@email.com', 'Rua das Flores, 123', '2024-01-15'), ('Bruno Santos', '22233344455', '1998-09-20', '48922223333', 'bruno.santos@email.com', 'Avenida Central, 456', '2024-01-20'),
('Carla Pereira', '33344455566', '1992-03-30', '48933334444', 'carla.pereira@email.com', 'Travessa dos Pássaros, 789', '2024-02-01'), ('Daniel Almeida', '44455566677', '2001-07-25', '48944445555', 'daniel.almeida@email.com', 'Rua da Praia, 101', '2024-02-10'),
('Eduarda Gomes', '55566677788', '1999-11-12', '48955556666', 'eduarda.gomes@email.com', 'Avenida Brasil, 212', '2024-03-05'), ('Fábio Rocha', '66677788899', '1994-01-08', '48966667777', 'fabio.rocha@email.com', 'Rua 7 de Setembro, 313', '2024-03-15'),
('Gabriela Dias', '77788899900', '1996-06-18', '48977778888', 'gabriela.dias@email.com', 'Alameda dos Anjos, 424', '2024-04-02'), ('Heitor Martins', '88899900011', '1990-12-30', '48988889999', 'heitor.martins@email.com', 'Rua Getúlio Vargas, 535', '2024-04-20'),
('Isabela Azevedo', '99900011122', '2000-02-28', '48999990000', 'isabela.azevedo@email.com', 'Rua do Comércio, 646', '2024-05-01'), ('João Mendes', '12312312312', '1997-08-15', '48912341234', 'joao.mendes@email.com', 'Avenida das Palmeiras, 757', '2024-05-10'),
('Larissa Souza', '23423423423', '1993-04-22', '48923452345', 'larissa.s@email.com', 'Rua Norte, 11', '2024-06-03'), ('Marcos Andrade', '34534534534', '1991-10-05', '48934563456', 'marcos.a@email.com', 'Rua Sul, 22', '2024-07-11'),
('Natália Barbosa', '45645645645', '1999-01-14', '48945674567', 'natalia.b@email.com', 'Rua Leste, 33', '2024-08-01'), ('Otávio Ramos', '56756756756', '2002-09-03', '48956785678', 'otavio.r@email.com', 'Rua Oeste, 44', '2024-09-09'),
('Patrícia Neves', '67867867867', '1995-12-19', '48967896789', 'patricia.n@email.com', 'Avenida Principal, 55', '2024-10-02'), ('Renato Farias', '78978978978', '1988-03-25', '48978907890', 'renato.f@email.com', 'Avenida Beira Mar, 66', '2024-11-15'),
('Sofia Monteiro', '89089089089', '1997-07-30', '48989018901', 'sofia.m@email.com', 'Rua dos Coqueiros, 77', '2024-12-01'), ('Thiago Gonçalves', '90190190190', '1994-05-16', '48990129012', 'thiago.g@email.com', 'Rua da Lagoa, 88', '2025-01-10'),
('Úrsula Pires', '11211211211', '1996-08-08', '48911221122', 'ursula.p@email.com', 'Travessa da Ilha, 99', '2025-02-05'), ('Victor Santos', '22322322322', '1992-11-21', '48922332233', 'victor.s@email.com', 'Rua da Montanha, 110', '2025-03-01'),
('Yasmin Lima', '33433433433', '2003-01-01', '48933443344', 'yasmin.l@email.com', 'Rua do Vale, 121', '2025-04-07'), ('Zeca Ribeiro', '44544544544', '1985-04-12', '48944554455', 'zeca.r@email.com', 'Avenida do Estado, 132', '2025-04-15'),
('Amanda Nogueira', '55655655655', '1998-09-17', '48955665566', 'amanda.n@email.com', 'Praça Central, 143', '2025-05-02'), ('Bento Correia', '66766766766', '1990-07-07', '48966776677', 'bento.c@email.com', 'Rua das Gaivotas, 154', '2025-05-20'),
('Cibele Ferraz', '77877877877', '1995-02-20', '48977887788', 'cibele.f@email.com', 'Rua dos Pardais, 165', '2025-06-01'), ('Davi Lucca', '10293847561', '1999-05-20', '48910293847', 'davi.lucca@email.com', 'Rua A, 1', '2024-01-22'),
('Emanuelly Castro', '20394857612', '2000-06-15', '48920394857', 'emanuelly.c@email.com', 'Rua B, 2', '2024-01-23'), ('Francisco Pinto', '30495867123', '1989-08-11', '48930495867', 'francisco.p@email.com', 'Rua C, 3', '2024-02-05'),
('Giovanna Cunha', '40596817234', '1994-02-28', '48940596817', 'giovanna.c@email.com', 'Rua D, 4', '2024-02-06'), ('Helena Justino', '50691827345', '1997-11-30', '48950691827', 'helena.j@email.com', 'Rua E, 5', '2024-03-11'),
('Igor Nogueira', '60192837456', '1996-09-14', '48960192837', 'igor.n@email.com', 'Rua F, 6', '2024-03-12'), ('Júlia Sampaio', '70293847561', '1995-04-19', '48970293847', 'julia.sampaio@email.com', 'Rua G, 7', '2024-04-15'),
('Kevin Macedo', '80394857123', '1998-01-01', '48980394857', 'kevin.macedo@email.com', 'Rua H, 8', '2024-04-16'), ('Lívia Campos', '90495867123', '2001-10-10', '48990495867', 'livia.campos@email.com', 'Rua I, 9', '2024-05-21'),
('Miguel Xavier', '11182736459', '1993-07-07', '48911182736', 'miguel.xavier@email.com', 'Rua J, 10', '2024-05-22'), ('Nicole Freitas', '21283746519', '1990-03-03', '48921283746', 'nicole.freitas@email.com', 'Rua K, 11', '2024-06-25'),
('Oscar Schmidt', '31384756129', '1985-05-05', '48931384756', 'oscar.s@email.com', 'Rua L, 12', '2024-06-26'), ('Pietra Tavares', '41485761239', '2002-08-08', '48941485761', 'pietra.tavares@email.com', 'Rua M, 13', '2024-07-29'),
('Quintino Moura', '51586712349', '1987-09-09', '48951586712', 'quintino.moura@email.com', 'Rua N, 14', '2024-07-30'), ('Raquel Lins', '61681723459', '1999-06-06', '48961681723', 'raquel.lins@email.com', 'Rua O, 15', '2024-08-28'),
('Samuel Veiga', '71182734569', '1994-02-02', '48971182734', 'samuel.veiga@email.com', 'Rua P, 16', '2024-08-29'), ('Tainá Queiroz', '81283745619', '1996-11-11', '48981283745', 'taina.queiroz@email.com', 'Rua Q, 17', '2024-09-25'),
('Ubiratan Guedes', '91384756129', '1991-01-01', '48991384756', 'ubiratan.guedes@email.com', 'Rua R, 18', '2024-09-26'), ('Valentina Prado', '12173645981', '2000-04-04', '48912173645', 'valentina.prado@email.com', 'Rua S, 19', '2024-10-23'),
('Wagner Mattos', '22274651982', '1986-07-07', '48922274651', 'wagner.mattos@email.com', 'Rua T, 20', '2024-10-24'), ('Xuxa Meneghel', '32375612983', '1963-03-27', '48932375612', 'xuxa.m@email.com', 'Rua U, 21', '2024-11-21'),
('Yago Peres', '42476123984', '1995-09-09', '48942476123', 'yago.peres@email.com', 'Rua V, 22', '2024-11-22'), ('Ziraldo Alves', '52571234985', '1932-10-24', '48952571234', 'ziraldo.a@email.com', 'Rua W, 23', '2024-12-19'),
('Alice Braga', '62672345986', '1983-04-15', '48962672345', 'alice.braga@email.com', 'Rua X, 24', '2024-12-20'), ('Bruno Gagliasso', '72134569871', '1982-04-13', '48972134569', 'bruno.g@email.com', 'Rua Y, 25', '2025-01-20'),
('Cauã Reymond', '82235619872', '1980-05-20', '48982235619', 'caua.r@email.com', 'Rua Z, 26', '2025-01-21'), ('Débora Falabella', '92336129873', '1979-02-22', '48992336129', 'debora.f@email.com', 'Rua AA, 27', '2025-02-19'),
('Eriberto Leão', '13124569874', '1972-06-11', '48913124569', 'eriberto.l@email.com', 'Rua BB, 28', '2025-02-20'), ('Fernanda Montenegro', '23225619875', '1929-10-16', '48923225619', 'fernanda.m@email.com', 'Rua CC, 29', '2025-03-19'),
('Gabriel Leone', '33326129876', '1993-07-21', '48933326129', 'gabriel.l@email.com', 'Rua DD, 30', '2025-03-20'), ('Hugo Moura', '43421239871', '1990-05-18', '48943421239', 'hugo.moura@email.com', 'Rua EE, 31', '2025-04-23'),
('Ícaro Silva', '53522349872', '1987-03-19', '48953522349', 'icaro.silva@email.com', 'Rua FF, 32', '2025-04-24'), ('Jesuíta Barbosa', '63623459873', '1991-06-26', '48963623459', 'jesuita.b@email.com', 'Rua GG, 33', '2025-05-21'),
('Klara Castanho', '73134569874', '2000-10-06', '48973134569', 'klara.c@email.com', 'Rua HH, 34', '2025-05-22'), ('Lázaro Ramos', '83235619875', '1978-11-01', '48983235619', 'lazaro.ramos@email.com', 'Rua II, 35', '2025-06-02'),
('Maisa Silva', '93336129876', '2002-05-22', '48993336129', 'maisa.silva@email.com', 'Rua JJ, 36', '2025-06-03'), ('Nanda Costa', '14124569871', '1986-09-24', '48914124569', 'nanda.costa@email.com', 'Rua KK, 37', '2024-03-18'),
('Otávio Müller', '24225619872', '1965-08-06', '48924225619', 'otavio.muller@email.com', 'Rua LL, 38', '2024-04-22'), ('Paloma Bernardi', '34326129873', '1985-04-21', '48934326129', 'paloma.b@email.com', 'Rua MM, 39', '2024-05-13'),
('Questran', '44421239874', '1990-01-01', '48944421239', 'q.uestran@email.com', 'Rua NN, 40', '2024-06-17'), ('Rodrigo Santoro', '54522349875', '1975-08-22', '48954522349', 'rodrigo.s@email.com', 'Rua OO, 41', '2024-07-15'),
('Selton Mello', '64623459876', '1972-12-30', '48964623459', 'selton.mello@email.com', 'Rua PP, 42', '2024-08-12'), ('Taís Araújo', '74134569871', '1978-11-25', '48974134569', 'tais.araujo@email.com', 'Rua QQ, 43', '2024-09-09'),
('Tony Ramos', '84235619872', '1948-08-25', '48984235619', 'tony.ramos@email.com', 'Rua RR, 44', '2024-10-14'), ('Vanessa Giácomo', '94336129873', '1983-03-29', '48994336129', 'vanessa.g@email.com', 'Rua SS, 45', '2024-11-11'),
('Wagner Moura', '15124569874', '1976-06-27', '48915124569', 'wagner.moura@email.com', 'Rua TT, 46', '2024-12-09'), ('Xande de Pilares', '25225619875', '1970-12-25', '48925225619', 'xande.pilares@email.com', 'Rua UU, 47', '2025-01-13'),
('Yasmin Brunet', '35326129876', '1988-06-06', '48935326129', 'yasmin.brunet@email.com', 'Rua VV, 48', '2025-02-10'), ('Zeca Pagodinho', '45421239871', '1959-02-04', '48945421239', 'zeca.pagodinho@email.com', 'Rua WW, 49', '2025-03-10'),
('Adriana Esteves', '55522349872', '1969-12-15', '48955522349', 'adriana.e@email.com', 'Rua XX, 50', '2025-04-07'), ('Alexandre Nero', '65623459873', '1970-02-13', '48965623459', 'alexandre.nero@email.com', 'Rua YY, 51', '2025-05-05'),
('Alinne Moraes', '75134569874', '1982-12-22', '48975134569', 'alinne.moraes@email.com', 'Rua ZZ, 52', '2025-06-02'), ('Andréia Horta', '85235619875', '1983-07-27', '48985235619', 'andreia.horta@email.com', 'Rua ABC, 53', '2024-07-22'),
('Antônio Fagundes', '95336129876', '1949-04-18', '48995336129', 'antonio.fagundes@email.com', 'Rua DEF, 54', '2024-08-19'), ('Aracy Balabanian', '16124569871', '1940-02-22', '48916124569', 'aracy.b@email.com', 'Rua GHI, 55', '2024-09-16');


-- ### ETAPA 2: GERAÇÃO DE DADOS TRANSACIONAIS EM ALTO VOLUME ###

-- 2.1 Gerando Assinaturas e Pagamentos para a maioria dos alunos
-- Inserções prévias mantidas + novas para cobrir mais alunos
INSERT INTO assinatura (matricula_aluno, cod_plano, data_inicio, data_fim, status_assinatura, valor_contratado) VALUES
(1, 3, '2024-01-15', '2025-01-14', 'Expirada', 1188.00), (1, 3, '2025-01-15', '2026-01-14', 'Ativa', 1188.00),
(2, 2, '2024-07-20', '2025-01-19', 'Expirada', 659.40), (3, 1, '2025-04-01', '2025-04-30', 'Expirada', 129.90),
(3, 1, '2025-05-01', '2025-05-31', 'Expirada', 129.90), (3, 1, '2025-06-01', '2025-06-30', 'Ativa', 129.90),
(10, 2, '2025-05-10', '2025-11-09', 'Ativa', 659.40), (18, 1, '2025-06-10', '2025-07-09', 'Ativa', 129.90),
(26, 3, '2024-01-22', '2025-01-21', 'Expirada', 1188.00), (27, 1, '2025-05-01', '2025-05-31', 'Expirada', 129.90),
(27, 1, '2025-06-01', '2025-06-30', 'Ativa', 129.90), (33, 2, '2024-05-22', '2024-11-21', 'Expirada', 659.40),
(40, 1, '2024-06-17', '2024-07-16', 'Expirada', 129.90), (41, 3, '2024-07-15', '2025-07-14', 'Ativa', 1188.00),
(50, 2, '2025-04-07', '2025-10-06', 'Ativa', 659.40), (55, 1, '2024-09-16', '2024-10-15', 'Expirada', 129.90),
(60, 2, '2025-03-20', '2025-09-19', 'Ativa', 659.40), (70, 1, '2025-06-03', '2025-07-02', 'Ativa', 129.90),
(77, 1, '2025-03-10', '2025-04-09', 'Expirada', 129.90);

INSERT INTO pagamento (cod_assinatura, data_vencimento, data_pagamento, valor_pago, status_pagamento) VALUES
(1, '2024-01-20', '2024-01-15', 1188.00, 'Pago'), (2, '2025-01-20', '2025-01-15', 1188.00, 'Pago'),
(3, '2024-07-25', '2024-07-22', 109.90, 'Pago'), (3, '2024-08-25', '2024-08-23', 109.90, 'Pago'),
(3, '2024-09-25', '2024-09-25', 109.90, 'Pago'), (3, '2024-10-25', '2024-10-24', 109.90, 'Pago'),
(3, '2024-11-25', '2024-11-25', 109.90, 'Pago'), (3, '2024-12-25', '2024-12-20', 109.90, 'Pago'),
(4, '2025-04-05', '2025-04-01', 129.90, 'Pago'), (5, '2025-05-05', '2025-05-02', 129.90, 'Pago'),
(6, '2025-06-05', '2025-06-01', 129.90, 'Pago'), (7, '2025-05-15', '2025-05-10', 659.40, 'Pago'),
(8, '2025-06-15', '2025-06-10', 129.90, 'Pago'), (9, '2024-01-27', '2024-01-22', 1188.00, 'Pago'),
(10, '2025-05-06', '2025-05-01', 129.90, 'Pago'), (11, '2025-06-06', '2025-06-01', 129.90, 'Pago'),
(12, '2024-05-27', '2024-05-22', 659.40, 'Pago'), (13, '2024-06-22', '2024-06-17', 129.90, 'Pago'),
(14, '2024-07-20', '2024-07-15', 1188.00, 'Pago'), (15, '2025-04-12', '2025-04-07', 659.40, 'Pago'),
(16, '2024-09-21', '2024-09-16', 129.90, 'Pago'), (17, '2025-03-25', '2025-03-20', 659.40, 'Pago'),
(18, '2025-06-08', '2025-06-03', 129.90, 'Pago'), (19, '2025-03-15', '2025-03-10', 129.90, 'Pago');

-- 2.2 Gerando Avaliações Físicas
INSERT INTO avaliacao_fisica (matricula_aluno, cod_instrutor, data_avaliacao, observacao_avaliacao) VALUES
(1, 4, '2024-01-20', 'Avaliação inicial.'), (1, 4, '2024-07-25', 'Reavaliação semestral.'),
(1, 4, '2025-01-30', 'Reavaliação anual.'), (10, 4, '2024-05-15', 'Avaliação inicial, foco hipertrofia.'),
(10, 4, '2024-11-20', 'Reavaliação. Bom ganho de massa.'), (10, 4, '2025-05-22', 'Reavaliação. Foco em definição.'),
(25, 4, '2025-06-05', 'Avaliação inicial.'), (35, 4, '2024-07-01', 'Avaliação inicial.'),
(35, 4, '2025-01-10', 'Reavaliação semestral.'), (50, 4, '2025-04-10', 'Avaliação inicial de aluna ativa.'),
(65, 4, '2025-02-15', 'Avaliação inicial.'), (75, 4, '2025-06-10', 'Avaliação de rotina.');

INSERT INTO resultado_avaliacao (cod_avaliacao_fisica, cod_tipo_medida, resultado) VALUES
(1, 1, 75.5), (1, 3, 32.5), (1, 4, 28.0), (2, 1, 68.2), (2, 3, 26.8), (2, 4, 30.5),
(3, 1, 67.0), (3, 3, 25.0), (3, 4, 31.0), (4, 1, 80.0), (4, 3, 18.0), (4, 4, 35.0),
(5, 1, 84.5), (5, 3, 16.5), (5, 4, 38.2), (6, 1, 86.0), (6, 3, 14.2), (6, 4, 39.5),
(7, 1, 58.0), (7, 3, 24.0), (7, 4, 25.0), (8, 1, 92.0), (8, 3, 28.0), (8, 4, 40.0),
(9, 1, 88.0), (9, 3, 25.0), (9, 4, 41.5), (10, 1, 65.0), (10, 3, 21.0), (10, 4, 29.0),
(11, 1, 72.0), (11, 3, 22.5), (11, 4, 33.0), (12, 1, 105.0), (12, 3, 35.0), (12, 4, 42.0);

-- 2.3 Gerando Fichas de Treino
INSERT INTO ficha_treino (matricula_aluno, cod_instrutor, data_inicio, data_fim) VALUES
(1, 1, '2024-07-25', '2024-10-24'),(10, 5, '2025-05-22', '2025-08-21'),(22, 6, '2024-11-22', '2025-02-21'),
(33, 7, '2024-05-25', '2024-08-24'),(44, 9, '2024-10-15', '2025-01-14'),(55, 1, '2024-09-20', '2024-12-19'),
(66, 10, '2024-11-15', '2025-02-14'),(77, 5, '2025-03-12', '2025-06-11');

INSERT INTO exe_ficha_treino (cod_ficha_treino, cod_exercicio, series, repeticoes, carga, tempo_descanso_segundos, ordem) VALUES
(1, 31, 4, '15', 100, 60, 1), (1, 7, 4, '15', 30, 60, 2), (1, 14, 4, '15', 20, 60, 3), (2, 1, 4, '8', 80, 90, 1), (2, 5, 4, '10', 16, 60, 2),
(2, 28, 4, '8-10', NULL, 90, 3), (3, 32, 3, '12', 120, 60, 1), (3, 35, 3, '12', 90, 60, 2), (4, 11, 5, '5', NULL, 120, 1), (4, 13, 5, '5', 180, 120, 2),
(5, 43, 3, '20', NULL, 45, 1), (5, 44, 3, '20', NULL, 45, 2), (6, 2, 4, '12', 12, 60, 1), (6, 16, 4, '12', 10, 60, 2),
(7, 30, 3, '15', 80, 60, 1), (7, 34, 3, '15', NULL, 60, 2), (8, 20, 4, '10', 15, 60, 1), (8, 25, 4, '10', 25, 60, 2);


INSERT INTO aula (nome_aula, cod_instrutor, cod_modalidade, cod_sala, data_aula, hora_inicio, hora_fim, limite_vagas) VALUES
('Spinning das 18h', 3, 2, 2, '2024-10-10', '18:00:00', '18:50:00', 20), ('Yoga Relax', 2, 3, 3, '2024-10-11', '19:00:00', '20:00:00', 25),
('Funcional Intenso', 8, 4, 3, '2024-11-12', '08:00:00', '08:50:00', 25), ('Pilates Solo', 2, 5, 3, '2024-11-14', '17:00:00', '17:50:00', 15),
('Spinning Matinal', 3, 2, 2, '2025-01-15', '07:00:00', '07:50:00', 20), ('Yoga Flow', 2, 3, 3, '2025-02-16', '19:00:00', '20:00:00', 25),
('Funcional Queima Total', 8, 4, 3, '2025-03-20', '18:00:00', '18:50:00', 25), ('Spinning Noturno', 3, 2, 2, '2025-05-28', '20:00:00', '20:50:00', 20);

INSERT INTO inscricao_aula (matricula_aluno, cod_aula, presenca_aula) VALUES
(3, 1, TRUE), (5, 1, TRUE), (11, 1, FALSE), (15, 1, TRUE), (7, 2, TRUE), (8, 2, FALSE), (12, 2, TRUE), (19, 2, TRUE),
(21, 3, TRUE), (28, 3, TRUE), (30, 3, TRUE), (33, 3, TRUE), (40, 4, TRUE), (42, 4, TRUE), (44, 4, TRUE),
(50, 5, TRUE), (51, 5, TRUE), (53, 5, TRUE), (55, 6, TRUE), (60, 6, FALSE), (62, 6, TRUE), (65, 7, TRUE),
(70, 7, TRUE), (77, 7, TRUE), (80, 8, TRUE), (2, 8, TRUE), (4, 8, TRUE), (6, 8, TRUE);


INSERT INTO frequencia (matricula_aluno, data_hora_entrada, data_hora_saida) VALUES
(1, '2025-06-02 18:00:00', '2025-06-02 19:30:00'), (2, '2025-06-02 18:05:00', '2025-06-02 19:25:00'),
(10, '2025-06-02 17:00:00', '2025-06-02 18:45:00'), (25, '2025-06-02 10:05:00', '2025-06-02 11:05:00'),
(41, '2025-06-02 07:00:00', '2025-06-02 08:30:00'), (50, '2025-06-02 19:10:00', '2025-06-02 20:40:00'),
(77, '2025-06-02 09:30:00', '2025-06-02 10:30:00'), (1, '2025-06-04 18:10:00', '2025-06-04 19:35:00'),
(2, '2025-06-04 18:02:00', '2025-06-04 19:20:00'), (10, '2025-06-04 17:05:00', '2025-06-04 18:50:00'),
(25, '2025-06-04 10:02:00', '2025-06-04 11:10:00'), (41, '2025-06-04 07:05:00', '2025-06-04 08:35:00'),
(50, '2025-06-04 19:15:00', '2025-06-04 20:45:00'), (77, '2025-06-04 09:35:00', '2025-06-04 10:35:00'),
(1, '2025-06-06 18:00:00', '2025-06-06 19:30:00'), (10, '2025-06-06 17:02:00', '2025-06-06 18:48:00'),
(25, '2025-06-06 10:10:00', '2025-06-06 11:15:00'), (41, '2025-06-06 07:02:00', '2025-06-06 08:32:00'),
(50, '2025-06-06 19:12:00', '2025-06-06 20:42:00'), (77, '2025-06-06 09:32:00', '2025-06-06 10:32:00');


INSERT INTO frequencia (matricula_aluno, data_hora_entrada, data_hora_saida) SELECT matricula_aluno, data_hora_entrada - INTERVAL '7 day', data_hora_saida - INTERVAL '7 day' FROM frequencia WHERE cod_frequencia <= 20;
INSERT INTO frequencia (matricula_aluno, data_hora_entrada, data_hora_saida) SELECT matricula_aluno, data_hora_entrada - INTERVAL '14 day', data_hora_saida - INTERVAL '14 day' FROM frequencia WHERE cod_frequencia <= 20;
INSERT INTO frequencia (matricula_aluno, data_hora_entrada, data_hora_saida) SELECT matricula_aluno, data_hora_entrada - INTERVAL '21 day', data_hora_saida - INTERVAL '21 day' FROM frequencia WHERE cod_frequencia <= 20;
INSERT INTO frequencia (matricula_aluno, data_hora_entrada, data_hora_saida) SELECT matricula_aluno, data_hora_entrada - INTERVAL '1 month', data_hora_saida - INTERVAL '1 month' FROM frequencia WHERE cod_frequencia <= 40;
INSERT INTO frequencia (matricula_aluno, data_hora_entrada, data_hora_saida) SELECT matricula_aluno, data_hora_entrada - INTERVAL '2 month', data_hora_saida - INTERVAL '2 month' FROM frequencia WHERE cod_frequencia <= 40;
INSERT INTO frequencia (matricula_aluno, data_hora_entrada, data_hora_saida) SELECT matricula_aluno, data_hora_entrada - INTERVAL '3 month', data_hora_saida - INTERVAL '3 month' FROM frequencia WHERE cod_frequencia <= 40;
INSERT INTO frequencia (matricula_aluno, data_hora_entrada, data_hora_saida) SELECT matricula_aluno, data_hora_entrada - INTERVAL '6 month', data_hora_saida - INTERVAL '6 month' FROM frequencia WHERE cod_frequencia <= 80;
