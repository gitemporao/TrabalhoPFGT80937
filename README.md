# Sistema de Gestão de Alunos e Avaliações
**Unidade Curricular:** Programação Funcional  
**Fase 1:** Modelação e Núcleo Funcional  
**Linguagem:** Haskell  

---

## 1. Descrição do Projeto

O **Sistema de Gestão de Alunos e Avaliações** é uma aplicação em Haskell para modelar e gerir o percurso académico dos alunos, as suas unidades curriculares e as respetivas avaliações/classificações.

Nesta **Fase 1**, o projeto foca-se estritamente nos alicerces fundamentais da programação funcional:
1. **Modelação de Domínio:** Definição rigorosa de tipos algébricos (`data`), sinónimos de tipos (`type`) e registos (*records*).
2. **Núcleo Funcional Puro:** Implementação de operações essenciais através de **funções puras**, **pattern matching** e **recursão estrutural explícita**.
3. **Ausência / Tratamento Inicial de Casos Limite:** Utilização segura de `Maybe` para pesquisas e cálculos onde os dados possam não existir.
4. **Conjunto de Dados de Teste:** Fixtures estáticas com alunos, UCs e avaliações para validação e testes unitários.

---

## 2. Estrutura do Projeto

O projeto segue a estrutura padrão recomendada no enunciado:

```text
PF/
├── cabal.project                      # Configuração do Cabal
├── sistema-gestao-avaliacoes.cabal    # Especificação do pacote, biblioteca, executável e testes
├── README.md                          # Este ficheiro descritivo
├── .gitignore                         # Ficheiros ignorados pelo Git
├── src/
│   ├── Model.hs                       # Definição dos tipos do domínio (Aluno, UC, Avaliacao, etc.)
│   ├── Domain.hs                      # Lógica pura, recursão e regras de cálculo
│   └── DataFixtures.hs                # Dados de teste para demonstração imediata
├── app/
│   └── Main.hs                        # Executável de demonstração da Fase 1
├── test/
│   └── Spec.hs                        # Testes unitários das funções puras
├── data/                              # Pasta para ficheiros de dados externos (Fases 2 e 3)
└── docs/                              # Documentação e relatórios
```

---

## 3. Conceitos Funcionais Aplicados na Fase 1

### Modelação (`src/Model.hs`)
* **Tipos Algébricos Próprios (`data`):**
  * `TipoAvaliacao`: `Teste | TrabalhoPratico | Exame | MiniTeste`
  * `UnidadeCurricular`: Registo com código, nome e ECTS.
  * `Aluno`: Registo com número de estudante (`AlunoId`), nome, e-mail e curso.
  * `Avaliacao`: Registo que associa um aluno a uma UC, peso percentual e nota (0.0 a 20.0).
  * `Sistema`: Estado global agregador.

### Funções Puras e Recursão (`src/Domain.hs`)
Todas as funções possuem assinaturas de tipo explícitas e funcionam de forma imutável:
* `inserirAluno :: Aluno -> [Aluno] -> [Aluno]` — inserção com substituição recursiva se o ID já existir;
* `buscarAlunoPorId :: AlunoId -> [Aluno] -> Maybe Aluno` — pesquisa recursiva com tratamento de ausência (`Maybe`);
* `alunosPorCurso :: String -> [Aluno] -> [Aluno]` — filtragem recursiva por curso;
* `contarAlunos :: [Aluno] -> Int` — contagem recursiva elementar de elementos;
* `avaliacoesAlunoUC :: AlunoId -> UCEId -> [Avaliacao] -> [Avaliacao]` — extração recursiva de avaliações de um aluno numa dada UC;
* `somaPonderadaRecursiva :: [Avaliacao] -> (Double, Double)` — cálculo recursivo do somatório de pesos e pontos;
* `calcularNotaFinalUC :: AlunoId -> UCEId -> [Avaliacao] -> Maybe Nota` — cálculo da média final com verificação de divisão por zero;
* `estaAprovadoUC :: AlunoId -> UCEId -> [Avaliacao] -> Maybe Bool` — verificação de aprovação ($\ge 9.5$);
* `notaMaxima`, `notaMinima :: [Nota] -> Maybe Nota` — determinação recursiva de extremos.

---

## 4. Como Compilar e Executar

### Opção A: Com o Cabal (Recomendado)
Para compilar e correr o executável de demonstração:
```bash
cabal run
```

Para correr a suite de testes:
```bash
cabal test
```

### Opção B: Com o GHCi (Interativo)
Caso queira testar diretamente no terminal interativo:
```bash
cd src
ghci Model.hs Domain.hs DataFixtures.hs
```
Exemplos de chamadas interativas no GHCi:
```haskell
-- Contar alunos
contarAlunos alunosExemplo

-- Pesquisar aluno
buscarAlunoPorId 202301 alunosExemplo

-- Nota final da aluna Ana Silva (202301) em PF
calcularNotaFinalUC 202301 "PF" avaliacoesExemplo

-- Verificar aprovação
estaAprovadoUC 202301 "PF" avaliacoesExemplo
```

### Opção C: Compilação Manual com GHC
```bash
ghc -i./src app/Main.hs -o sistema.exe
./sistema.exe
```

---

## 5. Identificação da Equipa
* **Elemento 1:** [Nome do Aluno] ([Número])
* **Elemento 2:** [Nome do Aluno] ([Número])
* **Elemento 3:** [Nome do Aluno] ([Número])
