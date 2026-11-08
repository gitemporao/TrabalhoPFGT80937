module Model where

-- | Identificador único de aluno (número mecanográfico)
type AlunoId = Int

-- | Nome do aluno ou da disciplina
type Nome = String

-- | Código de Unidade Curricular (ex: "PF", "AED")
type UCEId = String

-- | Nota de avaliação (0 a 20)
type Nota = Double

-- | Tipo de momento de avaliação
data TipoAvaliacao
    = Teste
    | TrabalhoPratico
    | Exame
    | MiniTeste
    deriving (Show, Eq, Read)

-- | Representação de uma Unidade Curricular
data UnidadeCurricular = UnidadeCurricular
    { ucCodigo :: UCEId
    , ucNome   :: Nome
    , ucEcts   :: Int
    } deriving (Show, Eq, Read)

-- | Representação de um Aluno
data Aluno = Aluno
    { alunoId    :: AlunoId
    , alunoNome  :: Nome
    , alunoEmail :: String
    , alunoCurso :: String
    } deriving (Show, Eq, Read)

-- | Registo individual de uma Avaliação de um Aluno numa UC
data Avaliacao = Avaliacao
    { avalAlunoId :: AlunoId
    , avalUCCod   :: UCEId
    , avalTipo    :: TipoAvaliacao
    , avalDesc    :: String
    , avalPeso    :: Double    -- Percentagem/ponderação (ex: 0.40 para 40%)
    , avalNota    :: Nota      -- Nota obtida (0.0 a 20.0)
    } deriving (Show, Eq, Read)

-- | Estado global do sistema agregando todas as entidades
data Sistema = Sistema
    { sistemaAlunos :: [Aluno]
    , sistemaUCs    :: [UnidadeCurricular]
    , sistemaAvals  :: [Avaliacao]
    } deriving (Show, Eq)
