# BIKE TIPO VC

Este projeto possui uma pasta chamada "docker", 
dentro da mesma existe um arquivo chamado `docker-compose.yml` que é 
responsável por construir o ambiente de desenvolvimento completo para o projeto.

#### Instalar o Docker e Docker-Compose

Para utilizar o ambiente que foi projetado utilizando os containers do `Docker` 
é necessário que tenha instalado em sua maquina o `docker` e `docker-compose`, 
assim, evitando quaisquer conflitos e dificuldades em subir o ambiente e o projeto.

- [Instalar Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce)
- [Instalar Docker-Compose](https://docs.docker.com/compose/install/#install-compose)

#### Utilizando o Docker

Ao clonar o projeto, basta acessar a pasta `docker` e executar os comandos abaixo:

``
    $ docker-compose build
    $ docker-compose up -d
``

os seguintes containers serão disponibilizados:

* bike_tipo_vc - Container da aplicação com Ruby e o framework Ruby on Rails.
* pgadmin - Container do PgAdmin, Ferramenta para Manipulação do Banco de Dados PostgreSQL
* postgres_db - Container do Banco de Dados PostgreSql
* portainer - Container Portainer, para gerenciar os Containers Locais

#### Executando o projeto dentro do container

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

#### Configurando o Gerenciador de Containers

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
