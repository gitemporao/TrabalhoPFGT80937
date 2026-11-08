# Trabalho Pratico de Programacao Funcional - Fase 1

Sistema de Gestao de Alunos e Notas desenvolvido em Haskell para a unidade curricular de Programacao Funcional.

## Elementos do Grupo
- Nome: [O Teu Nome] (Numero: [O Teu Numero])
- Nome: [Nome Colega] (Numero: [Numero Colega])

## O que foi feito nesta Fase 1
Nesta primeira fase implementamos as bases do sistema com tipos de dados proprios e funcoes puras com recursao e pattern matching:

1. **Modelos de dados (`src/Model.hs`):**
   - Tipos com `data` e records para `Aluno`, `UnidadeCurricular` e `Avaliacao`.
   - Tipo de dados para o tipo de prova (`Teste`, `Trabalho`, `Exame`).
   - Sinonimos de tipos (`NumeroAluno`, `CodigoUC`, `Nota`).

2. **Logica e funcoes funcionais (`src/Domain.hs`):**
   - Insercao e pesquisa recursiva de alunos (`adicionarAluno`, `procurarAluno`).
   - Filtragem de alunos por curso com recursao (`filtrarPorCurso`).
   - Calculo de media ponderada de avaliacoes usando uma funcao auxiliar recursiva (`calcularMediaUC`).
   - Verificacao de aproveitamento a uma disciplina (`alunoAprovado`).
   - Determinacao da nota mais alta de uma lista (`maiorNota`).
   - Uso de `Maybe` para tratar casos onde o elemento nao existe ou nao ha notas.

3. **Dados de exemplo (`src/DataFixtures.hs`):**
   - Lista com alunos, UCs e notas de exemplo para demonstracao.

4. **Demonstracao e Testes:**
   - `app/Main.hs`: Corre exemplos no ecra com os dados de teste.
   - `test/Spec.hs`: Testes simples para confirmar que as funcoes devolvem os valores esperados.

## Estrutura das pastas
```text
.
├── src/
│   ├── Model.hs         -- tipos e dados
│   ├── Domain.hs        -- funcoes puras e recursao
│   └── DataFixtures.hs  -- dados de teste
├── app/
│   └── Main.hs          -- programa principal de teste
├── test/
│   └── Spec.hs          -- testes
├── cabal.project
├── sistema-gestao-avaliacoes.cabal
└── README.md
```

## Como executar

### Com Cabal:
Executar a demonstracao:
```bash
cabal run
```

Executar os testes:
```bash
cabal test
```

### Com GHCi:
```bash
ghci src/Model.hs src/Domain.hs src/DataFixtures.hs
```
Exemplos de testes no GHCi:
```haskell
totalAlunos listaAlunos
procurarAluno 50001 listaAlunos
calcularMediaUC 50001 "PF" listaAvaliacoes
alunoAprovado 50001 "PF" listaAvaliacoes
```
