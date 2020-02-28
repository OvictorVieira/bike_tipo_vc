# BIKE TIPO VC

Este projeto possui uma pasta chamada "docker", 
dentro da mesma existe um arquivo chamado `docker-compose.yml` que é 
responsável por construir o ambiente de desenvolvimento completo para o projeto.

# Instalar o Docker e Docker-Compose

Para utilizar o ambiente que foi projetado utilizando os containers do `Docker` 
é necessário que tenha instalado em sua maquina o `docker` e `docker-compose`, 
assim, evitando quaisquer conflitos e dificuldades em subir o ambiente e o projeto.

- [Instalar Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce)
- [Instalar Docker-Compose](https://docs.docker.com/compose/install/#install-compose)

# Utilizando o Docker

Ao clonar o projeto, basta acessar a pasta `docker` e executar os comandos abaixo:

``
    $ docker-compose build
    $ docker-compose up -d
``

Após a execução dos comandos acima, seu ambiente estará pronto.

para visualizar os containers, acesse o [Portainer](localhost:9000) e siga as imagems a seguir:
 
* Crie um usuário e senha:

![Criando usuário e senha no Portainer](https://firebasestorage.googleapis.com/v0/b/images-d10d2.appspot.com/o/criando_usuario_e_senha.png?alt=media&token=c53a78f2-1ad5-4698-b4a0-d971ab7e725d)

* Clique na primeira opção para configurar a conexão local:

![Configurando opção para configurar a conexão local](https://firebasestorage.googleapis.com/v0/b/images-d10d2.appspot.com/o/configurando_conexao_local.png?alt=media&token=c43a7fbf-023a-46c1-90cc-cf1257430bab)

* Clique no botão `Local`:

![Acessando os containers locais](https://firebasestorage.googleapis.com/v0/b/images-d10d2.appspot.com/o/acessando_containers_locais.png?alt=media&token=1fe33f41-3279-4b52-bc20-df9521448b15)

* Clique em `Containers`:

![Acessando os containers](https://firebasestorage.googleapis.com/v0/b/images-d10d2.appspot.com/o/acessando_containers.png?alt=media&token=cb93b164-10b5-469a-a9cd-88d7e63714aa)

* Listagem dos containers Locais:

![Listagem dos containers Locais](https://firebasestorage.googleapis.com/v0/b/images-d10d2.appspot.com/o/lista%20de%20containers.png?alt=media&token=ecadb5b4-be70-49b1-9da3-b60b0552c336)
 
os seguintes containers serão disponibilizados:

* bike_tipo_vc - Container da aplicação com Ruby e o framework Ruby on Rails.
* pgadmin - Container do PgAdmin, Ferramenta para Manipulação do Banco de Dados PostgreSQL
* postgres_db - Container do Banco de Dados PostgreSql
* portainer - Container Portainer, para gerenciar os Containers Locais

# Executando o projeto dentro do container

Para acessar o ambiente de desenvolvimento dentro do container da aplicação, 
execute o seguinte comando:

``
    $ docker exec -it bike_tipo_vc bash
``

* Instale as dependências da aplicação `` bundle install ``
* Execute os comandos para o rails preparar seu ambiente:

   `` $ bundle exec rake db:create ``
   
   `` $ bundle exec rake db:migrate ``
   
   `` $ bundle exec rake db:migrate RAILS_ENV = test ``
   
* Suba o servidor do puma utilizando o comando: `` puma -p 3000 ``
* Em seu navegador, acesse: `` http://localhost:3000 ``

# Banco de Dados

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

# Tecnologias utilizadas

- Linguagem: Ruby 2.6.0
- Framework: Ruby on Rails 6.0.2.1
- Conteinerização: Docker
- Ferramenta para manipulação de Multiplos Containers: Docker Compose
- Banco de dados relacional: PostgreSQL

# Arquitetura do Banco de Dados

Para o banco de dados foi usado um banco relacional, pois fazendo uma analise do 
projeto Bike Para VC, percebi que tinha o uso de relacionamento entre algumas entidades
como por exemplo: *Um usuário aluga uma Bike para fazer uma Viagem entre uma Estação e outra*.

Neste caso, fiz a seguinte arquitetura de banco:

- Foi criado uma tabela para Usuários (users)
- Foi criado uma tabela para Bicicletas (bikes)
- Foi criado uma tabela para Estações (stations)
- Foi criado uma tabela para Viagens (trips)

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

Para a tabela **users** foram adicionadas as colunas *name* e *email* para controle dos usuários.

Para a tabela **stations** foi adicionada a coluna *name* para controle das Estações.

Para a tabela **trips** foram adicionado as seguinte colunas:
 - *started_at*: Data e hora de início
 - *finished_at*: Data e hora de fim
 - *traveled_distance*: Distância percorrida
 - *origin_station*: Estação de Origem
 - *destination_station*: Estação de Destino
 - *latitude*: Latitude da localização da Estação
 - *longitude*: Longitude da localização da Estação
 
Foi adicionado os campos *latitude* e *longitude* na tabela **stations** para que possamos realizar
os calculos de distância das viagens no final da mesma.
 
# Escolha do Framework e versão da Linguagem

Para este projeto foi utilizado a ultima versão estável do framework *Ruby on Rails 6* que é a versão *6.0.2.1*.
Foi escolhido a mesma por ser a ultima versão e não ser uma release candidata e sim uma 
release final.

Já a linguagem foi escolhido o Ruby na versão *2.6.0* por já possuir conhecimento na mesma
e também já possuir um container do docker preparado com a mesma, facilitando no desenvolvimento
do projeto.

# Escolha do Banco de Dados

Para o projeto foi escolhido o banco de dados PostgreSQL por ser mais robusto e ter mais
ferramentas a disposição e por trabalhar melhor com grande volume de dados, visto que nossa
aplicação pode crescer muito futuramente e ser disponibilizada no Brasil e fora.

Artigo lido que auxiliou na escolha do banco de dados entre PostgreSQL ou Mysql: [www.xplenty.com/postgresql-vs-mysql](https://www.xplenty.com/blog/postgresql-vs-mysql-which-one-is-better-for-your-use-case/)

# Arquitetura do Código

Na arquitetura do código foi usado a seguinte estrutura:

* `app/builders`: Foi adotado o padrão *Builder* *build* de algumas ações, para manter a controller *clean*
* `app/commands`: Foi adotado o padrão *Command* para executar alguns dos comandos como de *criação* ou *finalização* da Viagem
* `app/errors`: Foi criada a pasta *errors* para manter as *Exceptions* personalizadas.
* `app/policies`: Foi adotado o padrão *Policy* para manter as regras de negócio separadas das outras classes do sistema.
* `app/repositories`: Foi adotado o padrão *Repository* para manter as comunicações com o Banco de Dados separadas e manter as models *clean*
* `app/serializers`: Cria a serialização dos dados para retornar na API os dados formatados.
* `app/utils`: Foi criado essa pasta para deixar módulos úteis para o sistema, como formatação de data

Foi adotado o uso de *Docker* e *Docker-compose* no ambiente de desenvolvimento pois agiliza o processo de desenvolvimento
e mantém a maquina do desenvolvedor integra.