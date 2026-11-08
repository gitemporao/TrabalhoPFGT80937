module Main where

import Model
import Domain
import DataFixtures

main :: IO ()
main = do
    putStrLn "=== Sistema de Loja Online e Gestao de Stock (Fase 1) ==="
    putStrLn ""

    putStrLn "1. Total de tipos de produtos registados:"
    print (totalProdutos produtosExemplo)

    putStrLn "\n2. Procurar produto com ID 102:"
    print (procurarProduto 102 produtosExemplo)

    putStrLn "\n3. Procurar produto inexistente (ID 999):"
    print (procurarProduto 999 produtosExemplo)

    putStrLn "\n4. Produtos da categoria Informatica:"
    print (produtosPorCategoria Informatica produtosExemplo)

    putStrLn "\n5. Produtos com stock baixo (<= 3 unidades):"
    print (produtosStockBaixo 3 produtosExemplo)

    putStrLn "\n6. Calculo do total da Encomenda 1 (Joao Silva):"
    let totalEnc1 = totalEncomenda encomenda1 produtosExemplo
    putStrLn ("Total normal: " ++ show totalEnc1 ++ " EUR")
    let totalComDesconto = aplicarDesconto 10.0 totalEnc1
    putStrLn ("Total com 10% de desconto (>100 EUR): " ++ show totalComDesconto ++ " EUR")

    putStrLn "\n7. Calculo do total da Encomenda 2 (Maria Santos):"
    let totalEnc2 = totalEncomenda encomenda2 produtosExemplo
    putStrLn ("Total normal: " ++ show totalEnc2 ++ " EUR")

    putStrLn "\n8. Produto mais caro do catalogo:"
    print (produtoMaisCaro produtosExemplo)
