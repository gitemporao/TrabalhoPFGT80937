module Main where

import Model
import Domain
import DataFixtures

main :: IO ()
main = do
    putStrLn "A correr testes simples da Fase 1..."

    -- Teste contagem
    if totalAlunos listaAlunos == 3
        then putStrLn "[OK] Contagem de alunos"
        else putStrLn "[ERRO] Contagem de alunos"

    -- Teste pesquisa de aluno
    case procurarAluno 50001 listaAlunos of
        Just a  -> if nome a == "Joao Silva"
                       then putStrLn "[OK] Procura de aluno existente"
                       else putStrLn "[ERRO] Nome incorreto"
        Nothing -> putStrLn "[ERRO] Nao encontrou aluno"

    -- Teste pesquisa inexistente
    if procurarAluno 99999 listaAlunos == Nothing
        then putStrLn "[OK] Procura de aluno inexistente"
        else putStrLn "[ERRO] Devia ter retornado Nothing"

    -- Teste media ponderada (14*0.4 + 16*0.6 = 15.2)
    case calcularMediaUC 50001 "PF" listaAvaliacoes of
        Just m  -> if abs (m - 15.2) < 0.001
                       then putStrLn "[OK] Calculo de media ponderada"
                       else putStrLn "[ERRO] Valor de media errado"
        Nothing -> putStrLn "[ERRO] Falhou calculo da media"

    -- Teste aprovacao
    if alunoAprovado 50001 "PF" listaAvaliacoes == Just True &&
       alunoAprovado 50002 "PF" listaAvaliacoes == Just False
        then putStrLn "[OK] Verificacao de aprovacao"
        else putStrLn "[ERRO] Erro na verificacao de aprovacao"

    -- Teste maior nota
    if maiorNota [10.0, 18.0, 7.5] == Just 18.0
        then putStrLn "[OK] Maior nota calculada com sucesso"
        else putStrLn "[ERRO] Erro a calcular maior nota"

    putStrLn "Testes terminados!"
