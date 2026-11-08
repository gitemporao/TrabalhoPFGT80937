module Main where

import Model
import Domain
import DataFixtures

main :: IO ()
main = do
    putStrLn "=== Trabalho Pratico de PF - Fase 1 ==="
    putStrLn "Sistema de Gestao de Alunos e Notas"
    putStrLn ""

    putStrLn "1. Total de alunos registados:"
    print (totalAlunos listaAlunos)

    putStrLn "\n2. Procurar aluno com numero 50001:"
    print (procurarAluno 50001 listaAlunos)

    putStrLn "\n3. Procurar aluno inexistente (numero 99999):"
    print (procurarAluno 99999 listaAlunos)

    putStrLn "\n4. Alunos do curso LEI:"
    print (filtrarPorCurso "LEI" listaAlunos)

    putStrLn "\n5. Media do Joao Silva (50001) a PF:"
    let mediaJoao = calcularMediaUC 50001 "PF" listaAvaliacoes
    print mediaJoao

    putStrLn "\n6. O Joao passou a PF?"
    print (alunoAprovado 50001 "PF" listaAvaliacoes)

    putStrLn "\n7. A Maria passou a PF?"
    print (alunoAprovado 50002 "PF" listaAvaliacoes)

    putStrLn "\n8. Maior nota entre [12.0, 17.5, 9.0]:"
    print (maiorNota [12.0, 17.5, 9.0])
