module Main where

import Model
import Domain
import DataFixtures

assertEq :: (Eq a, Show a) => String -> a -> a -> IO ()
assertEq label actual expected =
    if actual == expected
        then putStrLn $ "[PASS] " ++ label
        else putStrLn $ "[FAIL] " ++ label ++ "\n  Esperado: " ++ show expected ++ "\n  Obtido:   " ++ show actual

main :: IO ()
main = do
    putStrLn "--- Execucao dos Testes da Fase 1 ---"

    -- Teste 1: Contagem de Alunos
    assertEq "Contar alunos de exemplo" (contarAlunos alunosExemplo) 4

    -- Teste 2: Procurar Aluno existente
    case buscarAlunoPorId 202301 alunosExemplo of
        Just a  -> assertEq "Buscar aluno 202301" (alunoNome a) "Ana Silva"
        Nothing -> putStrLn "[FAIL] Buscar aluno 202301 (retornou Nothing)"

    -- Teste 3: Procurar Aluno inexistente
    assertEq "Buscar aluno inexistente" (buscarAlunoPorId 999 alunosExemplo) Nothing

    -- Teste 4: Filtrar por curso
    let ei = alunosPorCurso "Engenharia Informatica" alunosExemplo
    assertEq "Alunos de EI (total)" (contarAlunos ei) 3

    -- Teste 5: Inserir novo aluno
    let novoAluno = Aluno 202305 "Eva Lima" "eva@univ.pt" "Ciencia de Dados"
    let listaAtualizada = inserirAluno novoAluno alunosExemplo
    assertEq "Contar apos insercao" (contarAlunos listaAtualizada) 5

    -- Teste 6: Calculo de Nota Final Ponderada (Ana Silva em PF)
    -- 16.5 * 0.20 + 17.0 * 0.40 + 15.0 * 0.40 = 3.3 + 6.8 + 6.0 = 16.1
    let notaAna = calcularNotaFinalUC 202301 "PF" avaliacoesExemplo
    assertEq "Nota de Ana em PF" notaAna (Just 16.1)

    -- Teste 7: Aprovacao
    assertEq "Ana aprovada em PF" (estaAprovadoUC 202301 "PF" avaliacoesExemplo) (Just True)
    assertEq "Bruno aprovado em PF" (estaAprovadoUC 202302 "PF" avaliacoesExemplo) (Just False)

    -- Teste 8: Maximo e Minimo
    let notas = [10.0, 18.5, 7.0, 14.0]
    assertEq "Nota Maxima" (notaMaxima notas) (Just 18.5)
    assertEq "Nota Minima" (notaMinima notas) (Just 7.0)
    assertEq "Nota Maxima de lista vazia" (notaMaxima []) Nothing

    putStrLn "--- Fim dos Testes ---"
