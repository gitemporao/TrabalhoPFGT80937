module DataFixtures where

import Model

-- Produtos em catalogo para teste
produtosExemplo :: [Produto]
produtosExemplo =
    [ Produto 101 "Rato Sem Fios" Informatica 25.0 15
    , Produto 102 "Teclado Mecanico" Informatica 80.0 5
    , Produto 103 "Camisola Algodao" Roupa 30.0 2
    , Produto 104 "Livro Haskell Basico" Livros 22.5 12
    , Produto 105 "Candeeiro Secretaria" Casa 35.0 1
    ]

-- Encomendas de exemplo
encomenda1 :: Encomenda
encomenda1 = Encomenda
    { encId      = 1
    , encCliente = "Joao Silva"
    , encItens   = [ ItemEncomenda 101 2   -- 2 * 25.0 = 50.0
                   , ItemEncomenda 102 1   -- 1 * 80.0 = 80.0 -> Total: 130.0
                   ]
    , encEstado  = Pendente
    }

encomenda2 :: Encomenda
encomenda2 = Encomenda
    { encId      = 2
    , encCliente = "Maria Santos"
    , encItens   = [ ItemEncomenda 104 2   -- 2 * 22.5 = 45.0
                   ]
    , encEstado  = Paga
    }

encomendasExemplo :: [Encomenda]
encomendasExemplo = [encomenda1, encomenda2]
