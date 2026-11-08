module Model where

-- Tipos basicos com sinonimos para facilitar a leitura
type NumeroAluno = Int
type Nome        = String
type CodigoUC    = String
type Nota        = Double

-- Tipos de avaliacao possiveis numa disciplina
data TipoAvaliacao
    = Teste
    | Trabalho
    | Exame
    deriving (Show, Eq)

-- Estrutura de um aluno
data Aluno = Aluno
    { numero :: NumeroAluno
    , nome   :: Nome
    , curso  :: String
    } deriving (Show, Eq)

-- Estrutura de uma Unidade Curricular
data UnidadeCurricular = UnidadeCurricular
    { codigo :: CodigoUC
    , designacao :: Nome
    , ects   :: Int
    } deriving (Show, Eq)

-- Registo de uma avaliacao individual
data Avaliacao = Avaliacao
    { numAluno :: NumeroAluno
    , codUC    :: CodigoUC
    , tipo     :: TipoAvaliacao
    , peso     :: Double   -- ex: 0.4 para 40%
    , nota     :: Nota     -- nota de 0 a 20
    } deriving (Show, Eq)
