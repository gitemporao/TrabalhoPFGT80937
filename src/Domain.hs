module Domain where

import Model

-- Adiciona um aluno a lista. Se o numero ja existir, atualiza os dados
adicionarAluno :: Aluno -> [Aluno] -> [Aluno]
adicionarAluno novo [] = [novo]
adicionarAluno novo (a:resto)
    | numero novo == numero a = novo : resto
    | otherwise               = a : adicionarAluno novo resto

-- Procura um aluno pelo seu numero
procurarAluno :: NumeroAluno -> [Aluno] -> Maybe Aluno
procurarAluno _ [] = Nothing
procurarAluno numProcurado (a:resto)
    | numero a == numProcurado = Just a
    | otherwise                = procurarAluno numProcurado resto

-- Filtra os alunos que pertencem a determinado curso
filtrarPorCurso :: String -> [Aluno] -> [Aluno]
filtrarPorCurso _ [] = []
filtrarPorCurso cursoDesejado (a:resto)
    | curso a == cursoDesejado = a : filtrarPorCurso cursoDesejado resto
    | otherwise                = filtrarPorCurso cursoDesejado resto

-- Conta quantos alunos existem na lista
totalAlunos :: [Aluno] -> Int
totalAlunos [] = 0
totalAlunos (_:resto) = 1 + totalAlunos resto

-- Procura uma UC pelo seu codigo (ex: "PF")
procurarUC :: CodigoUC -> [UnidadeCurricular] -> Maybe UnidadeCurricular
procurarUC _ [] = Nothing
procurarUC codProcurado (u:resto)
    | codigo u == codProcurado = Just u
    | otherwise                = procurarUC codProcurado resto

-- Retorna apenas as avaliacoes de um aluno numa certa UC
avaliacoesDoAlunoNaUC :: NumeroAluno -> CodigoUC -> [Avaliacao] -> [Avaliacao]
avaliacoesDoAlunoNaUC _ _ [] = []
avaliacoesDoAlunoNaUC num cod (av:resto)
    | numAluno av == num && codUC av == cod = av : avaliacoesDoAlunoNaUC num cod resto
    | otherwise                             = avaliacoesDoAlunoNaUC num cod resto

-- Funcao auxiliar recursiva para calcular:
-- soma das notas ponderadas (nota * peso) e soma dos pesos
somarNotasEPesos :: [Avaliacao] -> (Double, Double)
somarNotasEPesos [] = (0.0, 0.0)
somarNotasEPesos (av:resto) =
    let (somaNotasResto, somaPesosResto) = somarNotasEPesos resto
        pontos = nota av * peso av
    in (pontos + somaNotasResto, peso av + somaPesosResto)

-- Calcula a media final de um aluno a uma UC
-- Devolve Nothing se nao houver avaliacoes registadas
calcularMediaUC :: NumeroAluno -> CodigoUC -> [Avaliacao] -> Maybe Nota
calcularMediaUC num cod listaAvals =
    let avalsAluno = avaliacoesDoAlunoNaUC num cod listaAvals
    in case somarNotasEPesos avalsAluno of
        (_, 0.0) -> Nothing
        (totalPontos, totalPesos) -> Just (totalPontos / totalPesos)

-- Verifica se um aluno teve aproveitamento (nota final >= 9.5)
alunoAprovado :: NumeroAluno -> CodigoUC -> [Avaliacao] -> Maybe Bool
alunoAprovado num cod listaAvals =
    case calcularMediaUC num cod listaAvals of
        Nothing    -> Nothing
        Just media -> Just (media >= 9.5)

-- Encontra a nota mais alta de uma lista de notas
maiorNota :: [Nota] -> Maybe Nota
maiorNota [] = Nothing
maiorNota [x] = Just x
maiorNota (x:xs) =
    case maiorNota xs of
        Nothing -> Just x
        Just m  -> Just (if x > m then x else m)
