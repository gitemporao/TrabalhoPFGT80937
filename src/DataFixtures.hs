module DataFixtures where

import Model

-- Alguns alunos para teste
listaAlunos :: [Aluno]
listaAlunos =
    [ Aluno 50001 "Joao Silva" "LEI"
    , Aluno 50002 "Maria Santos" "LEI"
    , Aluno 50003 "Pedro Ferreira" "LCD"
    ]

-- Algumas UCs
listaUCs :: [UnidadeCurricular]
listaUCs =
    [ UnidadeCurricular "PF" "Programacao Funcional" 6
    , UnidadeCurricular "AED" "Algoritmos e Estruturas de Dados" 6
    ]

-- Avaliacoes de exemplo
listaAvaliacoes :: [Avaliacao]
listaAvaliacoes =
    [ -- Notas do Joao a PF (media ponderada: 14*0.4 + 16*0.6 = 5.6 + 9.6 = 15.2)
      Avaliacao 50001 "PF" Trabalho 0.40 14.0
    , Avaliacao 50001 "PF" Exame 0.60 16.0

      -- Notas da Maria a PF (media: 8*0.4 + 9*0.6 = 3.2 + 5.4 = 8.6 -> Reprovada)
    , Avaliacao 50002 "PF" Trabalho 0.40 8.0
    , Avaliacao 50002 "PF" Exame 0.60 9.0

      -- Notas do Pedro a AED
    , Avaliacao 50003 "AED" Teste 1.00 17.5
    ]
