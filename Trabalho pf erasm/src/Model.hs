module Model where

-- Sinonimos de tipos para tornar as assinaturas claras
type ProdutoId    = Int
type Nome         = String
type Preco        = Double
type Quantidade   = Int
type EncomendaId  = Int

-- Categorias possiveis de produtos na loja
data Categoria
    = Informatica
    | Roupa
    | Livros
    | Casa
    deriving (Show, Eq)

-- Representacao de um produto em catalogo/armazem
data Produto = Produto
    { prodId         :: ProdutoId
    , prodNome       :: Nome
    , prodCategoria  :: Categoria
    , prodPreco      :: Preco
    , prodStock      :: Quantidade
    } deriving (Show, Eq)

-- Item que faz parte de uma encomenda (id do produto e quantas unidades)
data ItemEncomenda = ItemEncomenda
    { itemProdId :: ProdutoId
    , itemQtd    :: Quantidade
    } deriving (Show, Eq)

-- Estado de processamento da encomenda
data EstadoEncomenda
    = Pendente
    | Paga
    | Enviada
    deriving (Show, Eq)

-- Representacao de uma encomenda feita por um cliente
data Encomenda = Encomenda
    { encId      :: EncomendaId
    , encCliente :: Nome
    , encItens   :: [ItemEncomenda]
    , encEstado  :: EstadoEncomenda
    } deriving (Show, Eq)
