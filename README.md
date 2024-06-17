# JayaChallenge

A aplicação conversor de moedas é uma API REST, chamada Jaya Currency Converter, com objetivo de converter valores de uma moeda de origem para uma moeda de destino.

Você pode fazer a conversão nas seguintes moedas:

- Real brasileiro
- Dólar americano
- Euro
- Iene japonês
As moedas serão referidas com o padrão internacional para facilitar a explicação.

## Informacoes Tecnicas

O projeto foi criado todo na linguagem Elixir na versão 1.13 utilizando o framwork Phoenix versão 1.6.

Para fazer as taxas de conversão foi utilizado a API do Exchangeratesapi.io

Para a persistência dos dados foi utilizado o PostgreSQL.

Outras bibliotecas que foram utilizadas:

- credo para garantir qualidade
- sobelow para checar as vulnerabilities do projeto
- excoveralls manter a cobertura e relatório de testes
- tesla cliente HTTP para fazer requisições

## Executando

Utilizando o docker-compose/docker, rode o seguinte comando para subir os containers

```bash
docker-compose up --build
```

O servidor estará sendo executado em modo DEV - Acesse localhost:4000/api para utilizar a API.

# Testes unitários

Para executar todos os testes unitários, execute o seguinte comando:

```bash
  mix test
```
