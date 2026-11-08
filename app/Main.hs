module Main where

import Model
import Domain
import DataFixtures

main :: IO ()
main = do
    putStrLn "=========================================================="
    putStrLn " Sistema de Gestao de Alunos e Avaliacoes - Fase 1"
    putStrLn "=========================================================="
    
    putStrLn "\n--- 1. Alunos Carregados ---"
    mapM_ (\a -> putStrLn $ "  [" ++ show (alunoId a) ++ "] " ++ alunoNome a ++ " (" ++ alunoCurso a ++ ")") alunosExemplo
    putStrLn $ "Total de Alunos (recursivo): " ++ show (contarAlunos alunosExemplo)

    putStrLn "\n--- 2. Filtragem por Curso (Engenharia Informatica) ---"
    let alunosEI = alunosPorCurso "Engenharia Informatica" alunosExemplo
    mapM_ (\a -> putStrLn $ "  - " ++ alunoNome a) alunosEI

    putStrLn "\n--- 3. Pesquisa de Aluno por ID ---"
    putStrLn $ "Procurar 202301: " ++ show (buscarAlunoPorId 202301 alunosExemplo)
    putStrLn $ "Procurar 999999: " ++ show (buscarAlunoPorId 999999 alunosExemplo)

    putStrLn "\n--- 4. Unidades Curriculares Registadas ---"
    mapM_ (\u -> putStrLn $ "  " ++ ucCodigo u ++ ": " ++ ucNome u ++ " (" ++ show (ucEcts u) ++ " ECTS)") ucsExemplo

    putStrLn "\n--- 5. Calculo de Avaliacoes e Aprovacao em PF ---"
    let idAna = 202301
    let idBruno = 202302

    let notaAna = calcularNotaFinalUC idAna "PF" avaliacoesExemplo
    let notaBruno = calcularNotaFinalUC idBruno "PF" avaliacoesExemplo

    putStrLn $ "Nota Final de Ana Silva (202301) em PF: " ++ show notaAna
    putStrLn $ "Ana Silva Aprovada? " ++ show (estaAprovadoUC idAna "PF" avaliacoesExemplo)

    putStrLn $ "Nota Final de Bruno Santos (202302) em PF: " ++ show notaBruno
    putStrLn $ "Bruno Santos Aprovado? " ++ show (estaAprovadoUC idBruno "PF" avaliacoesExemplo)

    putStrLn "\n--- 6. Extremos de Notas de Carla Mendes ---"
    let avalsCarla = avaliacoesAluno 202303 avaliacoesExemplo
    let notasCarla = extrairNotas avalsCarla
    putStrLn $ "Notas da Carla: " ++ show notasCarla
    putStrLn $ "Nota Maxima: " ++ show (notaMaxima notasCarla)
    putStrLn $ "Nota Minima: " ++ show (notaMinima notasCarla)

    putStrLn "\n=========================================================="
    putStrLn " Demonstracao da Fase 1 Concluida com Sucesso!"
    putStrLn "=========================================================="
