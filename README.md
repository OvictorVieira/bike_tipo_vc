# BIKE TIPO VC

# Hospedagem

O aplicativo está hospedado no Heroku, você consegue acessa-lo através clicando aqui [springfield-bike-tipo-vc.herokuapp.com/](https://springfield-bike-tipo-vc.herokuapp.com/).

# Sidekiq

Para realizar o monitoramento dos Workers, basta acessar a rota do Sidekiq, clicando aqui [springfield-bike-tipo-vc.herokuapp.com/sidekiq](https://springfield-bike-tipo-vc.herokuapp.com/sidekiq), 
O Usuário e senha você pode encontrar seguindo os passos abaixo:

**User**: `admin`
**Senha**: `Rails.application.config.app.sidekiq.password` (execute no console do rails `rails c`)

# Admin

Temos uma Dashboard Admin para gerenciamento do App, acesse a rota clicando aqui: [springfield-bike-tipo-vc.herokuapp.com/admin](springfield-bike-tipo-vc.herokuapp.com/admin).
O Usuário e senha você pode encontrar seguindo os passos abaixo:

**Email**: `admin@admin.com`
**Senha**: `Rails.application.credentials[:seeds][:admin][:password]` (execute no console do rails `rails c`)

#### Preparando o Ambiente

Para instalar o Ambiente de desenvolvimento, acesse o [Readme do Docker](docker/README.md) e siga as instruções.

##### Banco de Dados

A aplicação utiliza o banco de dados Postgres, com isso, para uso do projeto é necessário 
a criação de um **Server** no PgAdmin, para isso siga os comandos abaixo:

* Acesse o seu [Pgadmin](http://localhost:16543) local;
* Para acessar, utilize os dados abaixo:
* Usuário: biker@bike_tipo_vc.com
* Senha: BikeTipoVc2020!

![Fazendo Login no PGAdmin](https://firebasestorage.googleapis.com/v0/b/images-d10d2.appspot.com/o/login.png?alt=media&token=0ef3e323-fcbd-4d32-9304-17fa37b1dd10)

* Crie um server e insira um nome para o mesmo conforme imagem abaixo:

![Criação do Server no PGAdmin](https://firebasestorage.googleapis.com/v0/b/images-d10d2.appspot.com/o/configure_server.png?alt=media&token=3ddc49c1-c1b7-4885-a1bd-d6bba227185b)

* Na aba **Conections**, crie uma conexão conforme imagem abaixo:

![Criação da Conexão no PGAdmin](https://firebasestorage.googleapis.com/v0/b/images-d10d2.appspot.com/o/configure_connections.png?alt=media&token=5d612567-60f9-455c-b294-2d9ca39355df)

* Usuário: biker
* Senha: BikeTipoVc2020!

**PS.:** *Todas as senhas e usuários são para uso Local/Desenvolvimento*

## Arquitetura do Projeto

#### Tecnologias utilizadas

- Linguagem: Ruby 2.6.0
- Framework: Ruby on Rails 6.0.2.1
- Conteinerização: Docker
- Ferramenta para manipulação de Multiplos Containers: Docker Compose
- Banco de dados relacional: PostgreSQL

#### Arquitetura do Banco de Dados

Para o banco de dados foi usado um banco relacional, pois fazendo uma analise do 
projeto Bike Para VC, percebi que tinha o uso de relacionamento entre algumas entidades
como por exemplo: *Um usuário aluga uma Bike para fazer uma Viagem entre uma Estação e outra*.

Neste caso, fiz a seguinte arquitetura de banco:

- Foi criado uma tabela para Usuários (users)
- Foi criado uma tabela para Bicicletas (bikes)
- Foi criado uma tabela para Estações (stations)
- Foi criado uma tabela para Viagens (trips)
- Foi criado uma tabela para Salvar as Manutenções das Bikes (bike_maintenance)

Para as relações entre as tabelas, foi definido a seguinte arquitetura:

- Relacionamento *n x m* entre **users** e **bikes**

Deste relacionamento, foi gerado a tabela **trips** do relacionamento **n x m** das mesmas:
 
 - **users 1 X N trips**
 - **bikes 1 X N trips**
 
- Relacionamento **2 x N** entre **stations** e **trips**

O relacionamento foi definido como **2 x N** por a tabela **trips** possuir dois campos que
referenciam a tabela **stations**, sendo eles: *origin_station* e *destination_station* que 
referenciam a *primary_key* da tabela **stations**.

Para a tabela **bikes** foi adicionada a coluna *code* com tipo **String** e *unique* pois
a mesma terá um texto que será seu código de identificação que futuramente poderá ser usado
em um serviço externo que gerará o QRCode para uso nas Bikes e os mesmos serão salvos em um
serviço externo de Storage como Firebase ou Amazon S3 por exemplo.

Para a tabela **users** foram adicionadas as colunas *name*, *email* e *authentication_token* para controlar o acesso via 
API, além das colunas básicas para controle de senha.  

Para a tabela **stations** foi adicionada a coluna *name*, *latitude*, *longitude* para calcular a distância percorrida
na viagem dinamicamente e a coluna *vacancies* que mantém a quantidade de vagas suportada na Estação.

Para a tabela **trips** foram adicionado as seguinte colunas:
 - *started_at*: Data e hora de início
 - *finished_at*: Data e hora de fim
 - *traveled_distance*: Distância percorrida
 - *origin_station*: Estação de Origem
 - *destination_station*: Estação de Destino
 - *latitude*: Latitude da localização da Estação
 - *longitude*: Longitude da localização da Estação
 - *notification_delivered*: Usado para saber se o encerramento da viagem foi notificada nas API's registradas.
 
#### Escolha do Framework e versão da Linguagem

Para este projeto foi utilizado a ultima versão do framework *Ruby on Rails 6*.

Já a linguagem foi escolhido o Ruby na versão *2.6.0* por já possuir conhecimento na mesma.

#### Escolha do Banco de Dados

Para o projeto foi escolhido o banco de dados PostgreSQL por ser mais robusto e ter mais
ferramentas a disposição e por trabalhar melhor com grande volume de dados, visto que nossa
aplicação pode crescer muito futuramente e ser disponibilizada no Brasil e fora.

Artigo lido que auxiliou na escolha do banco de dados entre PostgreSQL ou Mysql: [www.xplenty.com/postgresql-vs-mysql](https://www.xplenty.com/blog/postgresql-vs-mysql-which-one-is-better-for-your-use-case/)

#### Arquitetura do Código

Na arquitetura do código foi usado a seguinte estrutura:

* `app/builders`: Foi adotado o padrão *Builder* *build* de algumas ações, para manter a controller *clean*
* `app/commands`: Foi adotado o padrão *Command* para executar alguns dos comandos como de *criação* ou *finalização* da Viagem
* `app/errors`: Foi criada a pasta *errors* para manter as *Exceptions* personalizadas.
* `app/facades`: Foi criado a pasta *facades* para adicionar as classes que irão realizar todo o processamento, deixando as camadas acima mais clean.
* `app/policies`: Foi adotado o padrão *Policy* para manter as regras de negócio separadas das outras classes do sistema.
* `app/publishers`: Foi criado a pasta *publishers* para manter os publicadores/notificadores, que no caso foi usado para realizar as notificações nas API's externas como a de Big Data.
* `app/repositories`: Foi adotado o padrão *Repository* para manter as comunicações com o Banco de Dados separadas e manter as models *clean*
* `app/serializers`: Cria a serialização dos dados para retornar na API os dados formatados.
* `app/services`: Foi criado a pasta *services* para manter separado o código dos serviços externos a aplicação, como comunicação com API's de terceiros.
* `app/subscribers`: Foi criado a pasta *subscribers* para manter os subscritos que serão notificados de alguma ação realizada pelos publishers.
* `app/utils`: Foi criado a pasta *utils* para deixar módulos úteis para o sistema, como formatação de data 
* `app/workers`: Foi criado a pasta *workers* para manter as classes dos Workers que serão usados para processar no Sidekiq.

Foi adotado o uso de *Docker* e *Docker-compose* no ambiente de desenvolvimento pois agiliza o processo de desenvolvimento
e mantém a maquina do desenvolvedor integra.

#### Notificações

Foi adotado modelo de publish e subscriber para realizar as notificações, onde foi feito o empilhamento de um Worker no sidekiq
para que não quebrasse o fluxo da finalização da viagem, assim notificando a API em background em um outro momento.

Foi adotado também um modelo de notificação com o `perform_in` randomico, assim não sobrecarregamos o banco caso sejam gerados
varias notificações no decorrer do tempo.

#### Gems usadas no projeto

##### Produção

* `active_model_serializers`: Foi utilizado para realizar a serialização dos dados no retorno da API.
* `swagger-docs`: Foi utilizado para geração automatica de documentação da API do projeto.
* `wisper`: Foi utilizado para realizar o modelo **Publish/Subscriber**.
* `sidekiq`: Foi utilizado para o uso de Filas e processos em Background.
* `httparty`: Foi utilizado para fazer requisições REST.
* `devise`: Foi utilizado para realizar a autenticação de login tanto na parte Webapp quanto na parte de API.
* `simple_token_authentication`: Foi utilizado para trabalhar junto ao *Devise*, realizando a autenticação de usuários na API.

##### Desenvolvimento/Teste

* `factory_bot_rails`: Utilizado para criar Mocks nos testes.
* `faker`: Utilizado para criação de dados ficticios nos Testes.
* `webmock`: Utilizado para criar mocks de requisições nos testes.
* `vcr`: Utilizado para criar Mocks das requisições, para não realizar as mesmas após a criação dos mocks.