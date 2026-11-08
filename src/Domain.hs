module Domain where

import Model

-- ============================================================================
-- Funções de Gestão de Alunos (Recursão e Pattern Matching)
-- ============================================================================

-- | Inserir um aluno na lista (evita duplicados pelo alunoId)
inserirAluno :: Aluno -> [Aluno] -> [Aluno]
inserirAluno novo [] = [novo]
inserirAluno novo (a:as)
    | alunoId novo == alunoId a = novo : as  -- Atualiza se já existir
    | otherwise                 = a : inserirAluno novo as

-- | Procurar aluno por ID recursivamente
buscarAlunoPorId :: AlunoId -> [Aluno] -> Maybe Aluno
buscarAlunoPorId _ [] = Nothing
buscarAlunoPorId targetId (a:as)
    | alunoId a == targetId = Just a
    | otherwise             = buscarAlunoPorId targetId as

-- | Filtrar alunos pertencentes a um curso específico (recursão pura)
alunosPorCurso :: String -> [Aluno] -> [Aluno]
alunosPorCurso _ [] = []
alunosPorCurso cursoAlvo (a:as)
    | alunoCurso a == cursoAlvo = a : alunosPorCurso cursoAlvo as
    | otherwise                 = alunosPorCurso cursoAlvo as

-- | Contar número total de alunos recursivamente
contarAlunos :: [Aluno] -> Int
contarAlunos [] = 0
contarAlunos (_:as) = 1 + contarAlunos as


-- ============================================================================
-- Funções de Gestão de Unidades Curriculares
-- ============================================================================

-- | Inserir UC na lista de UCs
inserirUC :: UnidadeCurricular -> [UnidadeCurricular] -> [UnidadeCurricular]
inserirUC nova [] = [nova]
inserirUC nova (u:us)
    | ucCodigo nova == ucCodigo u = nova : us
    | otherwise                   = u : inserirUC nova us

-- | Buscar UC por código
buscarUCPorCod :: UCEId -> [UnidadeCurricular] -> Maybe UnidadeCurricular
buscarUCPorCod _ [] = Nothing
buscarUCPorCod cod (u:us)
    | ucCodigo u == cod = Just u
    | otherwise         = buscarUCPorCod cod us


-- ============================================================================
-- Funções de Gestão e Análise de Avaliações (Cálculo e Recursão)
-- ============================================================================

-- | Registar uma nova avaliação
registarAvaliacao :: Avaliacao -> [Avaliacao] -> [Avaliacao]
registarAvaliacao nova avals = nova : avals

-- | Obter todas as avaliações de um aluno numa UC específica
avaliacoesAlunoUC :: AlunoId -> UCEId -> [Avaliacao] -> [Avaliacao]
avaliacoesAlunoUC _ _ [] = []
avaliacoesAlunoUC aid cod (av:avs)
    | avalAlunoId av == aid && avalUCCod av == cod = av : avaliacoesAlunoUC aid cod avs
    | otherwise                                   = avaliacoesAlunoUC aid cod avs

-- | Obter todas as avaliações de um aluno (em todas as disciplinas)
avaliacoesAluno :: AlunoId -> [Avaliacao] -> [Avaliacao]
avaliacoesAluno _ [] = []
avaliacoesAluno aid (av:avs)
    | avalAlunoId av == aid = av : avaliacoesAluno aid avs
    | otherwise             = avaliacoesAluno aid avs

-- | Calcular soma ponderada (nota * peso) e soma dos pesos recursivamente
-- Retorna (somaPonderada, somaPesos)
somaPonderadaRecursiva :: [Avaliacao] -> (Double, Double)
somaPonderadaRecursiva [] = (0.0, 0.0)
somaPonderadaRecursiva (av:avs) =
    let (restoPontos, restoPesos) = somaPonderadaRecursiva avs
        pontos = avalNota av * avalPeso av
        pesos  = avalPeso av
    in (pontos + restoPontos, pesos + restoPesos)

-- | Calcular a média final de um aluno numa dada UC
-- Se não tiver avaliações ou a soma de pesos for 0, retorna Nothing
calcularNotaFinalUC :: AlunoId -> UCEId -> [Avaliacao] -> Maybe Nota
calcularNotaFinalUC aid cod avals =
    let avalsAluno = avaliacoesAlunoUC aid cod avals
    in case somaPonderadaRecursiva avalsAluno of
        (_, 0.0) -> Nothing
        (pontos, pesos) -> Just (pontos / pesos)

-- | Determinar se o aluno está aprovado numa UC (Nota >= 9.5)
estaAprovadoUC :: AlunoId -> UCEId -> [Avaliacao] -> Maybe Bool
estaAprovadoUC aid cod avals =
    case calcularNotaFinalUC aid cod avals of
        Nothing   -> Nothing
        Just nota -> Just (nota >= 9.5)

-- | Listar notas de todas as avaliações de um aluno
extrairNotas :: [Avaliacao] -> [Nota]
extrairNotas [] = []
extrairNotas (av:avs) = avalNota av : extrairNotas avs

-- | Encontrar a nota máxima recursivamente
notaMaxima :: [Nota] -> Maybe Nota
notaMaxima [] = Nothing
notaMaxima [x] = Just x
notaMaxima (x:xs) =
    case notaMaxima xs of
        Nothing -> Just x
        Just m  -> Just (if x > m then x else m)

-- | Encontrar a nota mínima recursivamente
notaMinima :: [Nota] -> Maybe Nota
notaMinima [] = Nothing
notaMinima [x] = Just x
notaMinima (x:xs) =
    case notaMinima xs of
        Nothing -> Just x
        Just m  -> Just (if x < m then x else m)
