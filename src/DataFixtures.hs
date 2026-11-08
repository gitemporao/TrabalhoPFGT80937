module DataFixtures where

import Model

-- | Conjunto de dados de teste para Alunos
alunosExemplo :: [Aluno]
alunosExemplo =
    [ Aluno 202301 "Ana Silva" "ana.silva@universidade.pt" "Engenharia Informatica"
    , Aluno 202302 "Bruno Santos" "bruno.santos@universidade.pt" "Engenharia Informatica"
    , Aluno 202303 "Carla Mendes" "carla.mendes@universidade.pt" "Ciencia de Dados"
    , Aluno 202304 "Diogo Costa" "diogo.costa@universidade.pt" "Engenharia Informatica"
    ]

-- | Conjunto de dados de teste para Unidades Curriculares
ucsExemplo :: [UnidadeCurricular]
ucsExemplo =
    [ UnidadeCurricular "PF" "Programacao Funcional" 6
    , UnidadeCurricular "AED" "Algoritmos e Estruturas de Dados" 6
    , UnidadeCurricular "BD" "Bases de Dados" 6
    ]

-- | Conjunto de dados de teste para Avaliações
avaliacoesExemplo :: [Avaliacao]
avaliacoesExemplo =
    [ -- Ana Silva (202301) em PF
      Avaliacao 202301 "PF" MiniTeste "Mini-teste 1" 0.20 16.5
    , Avaliacao 202301 "PF" TrabalhoPratico "Trabalho Fase 1" 0.40 17.0
    , Avaliacao 202301 "PF" Exame "Exame Final" 0.40 15.0

      -- Bruno Santos (202302) em PF
    , Avaliacao 202302 "PF" MiniTeste "Mini-teste 1" 0.20 8.0
    , Avaliacao 202302 "PF" TrabalhoPratico "Trabalho Fase 1" 0.40 9.0
    , Avaliacao 202302 "PF" Exame "Exame Final" 0.40 8.5

      -- Carla Mendes (202303) em PF e AED
    , Avaliacao 202303 "PF" TrabalhoPratico "Trabalho Fase 1" 0.50 18.0
    , Avaliacao 202303 "PF" Exame "Exame Final" 0.50 19.0
    , Avaliacao 202303 "AED" Teste "Teste 1" 1.00 14.5
    ]

-- | Estado inicial completo com os dados de exemplo
sistemaExemplo :: Sistema
sistemaExemplo = Sistema
    { sistemaAlunos = alunosExemplo
    , sistemaUCs    = ucsExemplo
    , sistemaAvals  = avaliacoesExemplo
    }
