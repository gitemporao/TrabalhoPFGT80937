# Trabalho Pratico de Programacao Funcional - Fase 1

## Tema: Sistema de Loja Online e Gestao de Stock
Aplicacao desenvolvida em Haskell para gestao de produtos, inventario/stock e processamento de encomendas.

---

## 1. Identificacao do Grupo
- **Aluno 1:** [O Teu Nome] ([O Teu Numero])
- **Aluno 2:** [Nome Colega] ([Numero Colega])

---

## 2. Descricao do Problema e Ambito
O objetivo desta aplicacao e fornecer um nucleo funcional puro para:
- Gerir o catalogo de produtos e niveis de stock em armazem;
- Controlar artigos com rutura ou stock baixo;
- Processar encomendas de clientes, calculando valores totais e aplicacao de campanhas de desconto;
- Garantir a integridade dos dados atraves do sistema de tipos estatico do Haskell.

---

## 3. Modelação e Conceitos Funcionais Aplicados (Fase 1)

### Modelação de Dados (`src/Model.hs`)
- **Tipos de dados algebricos (`data`):**
  - `Categoria`: `Informatica | Roupa | Livros | Casa`
  - `EstadoEncomenda`: `Pendente | Paga | Enviada`
- **Registos (Records):**
  - `Produto`: Identificador unico (`ProdutoId`), nome, categoria, preco e quantidade disponivel em stock.
  - `ItemEncomenda`: Par composto pelo ID do produto e respetiva quantidade pedida.
  - `Encomenda`: Identificador da encomenda, nome do cliente, lista de itens encomendados e estado da encomenda.
- **Sinonimos de Tipos (`type`):**
  - `type ProdutoId = Int`, `type Preco = Double`, `type Quantidade = Int`, etc.

### Núcleo Funcional e Recursão (`src/Domain.hs`)
Todas as operacoes da Fase 1 foram implementadas atraves de funcoes puras, com assinaturas de tipo explicitas e recursao estrutural:
- `adicionarProduto`: Adicao com atualizacao automatica se o ID ja existir;
- `procurarProduto`: Pesquisa recursiva protegida com `Maybe` (evita falhas de execucao caso nao exista);
- `produtosPorCategoria`: Filtragem recursiva de artigos por categoria;
- `produtosStockBaixo`: Detecao recursiva de produtos com quantidade inferior ou igual a um limite de seguranca;
- `atualizarStock`: Atualizacao da quantidade em armazem garantindo que nao fica negativo;
- `totalEncomenda`: Calculo acumulado do valor dos itens de uma encomenda atraves de recursao;
- `aplicarDesconto`: Regra de negocio simples de aplicacao de percentagem de desconto para valores superiores a 100 EUR;
- `produtoMaisCaro`: Determinacao recursiva do elemento maximo do inventario.

---

## 4. Estrutura do Projeto

```text
PF/
├── src/
│   ├── Model.hs               -- Definicao dos tipos de dados e registos
│   ├── Domain.hs              -- Nucleo funcional puro e funcoes recursivas
│   └── DataFixtures.hs        -- Dados estaticos de exemplo para testes
├── app/
│   └── Main.hs                -- Programa principal de demonstracao no terminal
├── test/
│   └── Spec.hs                -- Testes unitarios simples com verificacao de resultados
├── loja-online-stock.cabal    -- Configuracao do pacote Cabal
├── cabal.project              -- Projeto Cabal
├── README.md                  -- Documentacao da Fase 1
└── .gitignore                 -- Ficheiros temporarios ignorados
```

---

## 5. Como Compilar e Executar

### Utilizando o Cabal
Para compilar e correr o programa de demonstracao:
```bash
cabal run
```

Para correr os testes da aplicacao:
```bash
cabal test
```

### Utilizando o GHCi (Terminal Interativo)
```bash
ghci src/Model.hs src/Domain.hs src/DataFixtures.hs
```

Exemplos de testes interativos:
```haskell
-- Ver total de produtos
totalProdutos produtosExemplo

-- Procurar um produto
procurarProduto 101 produtosExemplo

-- Ver produtos com stock critico (<= 2 unidades)
produtosStockBaixo 2 produtosExemplo

-- Ver custo da encomenda 1
totalEncomenda encomenda1 produtosExemplo

-- Ver o produto mais caro
produtoMaisCaro produtosExemplo
```
