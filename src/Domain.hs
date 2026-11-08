module Domain where

import Model

-- ============================================================================
-- Gestao de Produtos e Stock (Funcoes Puras e Recursao)
-- ============================================================================

-- Adiciona um produto ao inventario. Se ja existir com esse ID, atualiza os dados
adicionarProduto :: Produto -> [Produto] -> [Produto]
adicionarProduto novo [] = [novo]
adicionarProduto novo (p:resto)
    | prodId novo == prodId p = novo : resto
    | otherwise               = p : adicionarProduto novo resto

-- Procura um produto pelo seu ID usando Maybe para caso nao exista
procurarProduto :: ProdutoId -> [Produto] -> Maybe Produto
procurarProduto _ [] = Nothing
procurarProduto targetId (p:resto)
    | prodId p == targetId = Just p
    | otherwise            = procurarProduto targetId resto

-- Filtra os produtos de uma determinada categoria
produtosPorCategoria :: Categoria -> [Produto] -> [Produto]
produtosPorCategoria _ [] = []
produtosPorCategoria cat (p:resto)
    | prodCategoria p == cat = p : produtosPorCategoria cat resto
    | otherwise              = produtosPorCategoria cat resto

-- Lista de produtos que estao com stock em rutura ou baixo (<= limite)
produtosStockBaixo :: Quantidade -> [Produto] -> [Produto]
produtosStockBaixo _ [] = []
produtosStockBaixo limite (p:resto)
    | prodStock p <= limite = p : produtosStockBaixo limite resto
    | otherwise             = produtosStockBaixo limite resto

-- Conta recursivamente o numero total de produtos registados
totalProdutos :: [Produto] -> Int
totalProdutos [] = 0
totalProdutos (_:resto) = 1 + totalProdutos resto

-- Atualiza a quantidade em stock de um produto
atualizarStock :: ProdutoId -> Quantidade -> [Produto] -> [Produto]
atualizarStock _ _ [] = []
atualizarStock pid delta (p:resto)
    | prodId p == pid =
        let novoStock = if prodStock p + delta < 0 then 0 else prodStock p + delta
        in p { prodStock = novoStock } : resto
    | otherwise = p : atualizarStock pid delta resto


-- ============================================================================
-- Calculos de Encomendas e Totais
-- ============================================================================

-- Calcula o valor de um item (preco * quantidade). Devolve 0.0 se nao encontrar o produto
valorItem :: ItemEncomenda -> [Produto] -> Double
valorItem item prods =
    case procurarProduto (itemProdId item) prods of
        Just p  -> prodPreco p * fromIntegral (itemQtd item)
        Nothing -> 0.0

-- Calcula o valor total de uma lista de itens recursivamente
calcularTotalItens :: [ItemEncomenda] -> [Produto] -> Double
calcularTotalItens [] _ = 0.0
calcularTotalItens (item:resto) prods =
    valorItem item prods + calcularTotalItens resto prods

-- Calcula o custo total de uma encomenda
totalEncomenda :: Encomenda -> [Produto] -> Double
totalEncomenda enc prods = calcularTotalItens (encItens enc) prods

-- Aplica um desconto caso o total atinja um valor minimo (ex: 10% se total > 100)
aplicarDesconto :: Double -> Double -> Double
aplicarDesconto percentagem total
    | total >= 100.0 = total - (total * (percentagem / 100.0))
    | otherwise      = total

-- Encontra recursivamente o produto mais caro de uma lista
produtoMaisCaro :: [Produto] -> Maybe Produto
produtoMaisCaro [] = Nothing
produtoMaisCaro [p] = Just p
produtoMaisCaro (p:resto) =
    case produtoMaisCaro resto of
        Nothing -> Just p
        Just outro ->
            if prodPreco p > prodPreco outro
                then Just p
                else Just outro
