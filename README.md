# Projeto Leilão de Estoque

<img src="https://i.imgur.com/LVPF5dm.png" alt="Homepage da Aplicação" />


## Descrição do Projeto

O projeto Leilão de Estoque consiste numa aplicação fullstack desenvolvida em Ruby usando o framework Rails, com a utilização do SQLite como banco de dados. O projeto tem como objetivo desenvolver uma aplicação que faz o gerenciamento de leilões de uma determinada empresa.

## Principais Funcionalidades

- [X] Sistema de Login e Cadastro de Contas de Usuário e Administrador

- [X] Cadastro de Itens para Leilão

- [X] Criação, Adição de Itens e Aprovação de Lotes de Leilão

- [X] Visualização de Forma Separada dos Lotes em Andamento e Futuros na Página Inicial

- [X] Realização de Lances por Usuários, Considerando o Valor Mínimo e a Diferença Mínima

- [X] Visualização dos Lotes Finalizados para Encerramento ou Cancelamento

- [X] Visualização pelos Usuários dos Lotes em que Foram Vencedores do Leilão

- [X] Realização de Perguntas pelo Usuário que Podem Ser Respondidas ou Ocultadas pelo Administrador

- [ ] Sistema de Suspensão de CPFs Bloqueados

- [ ] Adição e Remoção pelo Usuário de Lotes da Sua Lista de Favoritos

- [X] Pesquisa de Lotes Através do Código e do Nome dos Itens

> Status do Projeto: Em desenvolvimento :warning:

## Como Rodar a Aplicação

No terminal, clone o projeto:

```
git clone git@github.com:rafaeldejesusl/ProjectAuctionApp.git
```

Entre na pasta do projeto:

```
cd ProjectAuctionApp
```

Instale as dependências:

```
bin/setup
```

Execute a aplicação:

```
rails server
```

A aplicação estará disponível para acesso a partir da rota `http://localhost:3000`

## Linguagens e dependências utilizadas

- [Ruby](https://ruby-doc.org/)

- [Rails](https://guides.rubyonrails.org/)

- [SQLite](https://sqlite.org/docs.html)

- [Devise](https://rubygems.org/gems/devise)

- [cpf_cnpj](https://rubygems.org/gems/cpf_cnpj)

- [RSpec](https://rubygems.org/gems/rspec)

- [Capybara](https://rubygems.org/gems/capybara)

## Testes

A aplicação foi desenvolvida utilizando o TDD, como todos os testes passando. Para executar os testes:

```
rspec
```

## Feedbacks

Caso tenha alguma sugestão ou tenha encontrado algum erro no código, estou disponível para contato no meu [LinkedIn](https://www.linkedin.com/in/rafael-de-jesus-lima/)
