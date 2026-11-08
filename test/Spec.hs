module Main where

import Model
import Domain
import DataFixtures

main :: IO ()
main = do
    putStrLn "A correr testes da Fase 1..."

    -- Teste contagem de produtos
    if totalProdutos produtosExemplo == 5
        then putStrLn "[OK] Contagem de produtos"
        else putStrLn "[ERRO] Contagem de produtos"

    -- Teste procura de produto
    case procurarProduto 101 produtosExemplo of
        Just p  -> if prodNome p == "Rato Sem Fios"
                       then putStrLn "[OK] Procura de produto existente"
                       else putStrLn "[ERRO] Nome do produto incorreto"
        Nothing -> putStrLn "[ERRO] Nao encontrou produto 101"

    -- Teste procura de produto inexistente
    if procurarProduto 999 produtosExemplo == Nothing
        then putStrLn "[OK] Procura de produto inexistente devolve Nothing"
        else putStrLn "[ERRO] Devia ter retornado Nothing"

    -- Teste de filtragem por categoria
    let informatica = produtosPorCategoria Informatica produtosExemplo
    if totalProdutos informatica == 2
        then putStrLn "[OK] Filtragem por categoria"
        else putStrLn "[ERRO] Erro na filtragem de informatica"

    -- Teste de deteção de stock baixo (<= 2 unidades: Candeeiro com 1 e Camisola com 2)
    let stockCritico = produtosStockBaixo 2 produtosExemplo
    if totalProdutos stockCritico == 2
        then putStrLn "[OK] Identificacao de stock baixo"
        else putStrLn "[ERRO] Erro na contagem de stock baixo"

    -- Teste de total da encomenda 1 (2 * 25.0 + 1 * 80.0 = 130.0)
    let t1 = totalEncomenda encomenda1 produtosExemplo
    if abs (t1 - 130.0) < 0.001
        then putStrLn "[OK] Calculo do total da encomenda 1"
        else putStrLn "[ERRO] Total da encomenda 1 calculado incorretamente"

    -- Teste do desconto (130 - 10% = 117.0)
    let comDesc = aplicarDesconto 10.0 t1
    if abs (comDesc - 117.0) < 0.001
        then putStrLn "[OK] Aplicacao de desconto"
        else putStrLn "[ERRO] Erro no desconto"

    -- Teste de produto mais caro (Teclado Mecanico a 80.0)
    case produtoMaisCaro produtosExemplo of
        Just p  -> if prodPreco p == 80.0
                       then putStrLn "[OK] Detecao do produto mais caro"
                       else putStrLn "[ERRO] Preco do mais caro errado"
        Nothing -> putStrLn "[ERRO] Falha ao encontrar o mais caro"

    putStrLn "Todos os testes terminados!"
