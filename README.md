# Configurar Vagrant no OS X (Yosemite)
## Requisitos

* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://vagrantup.com)

## Introdução
Monta um ambiente básico pra dev em rails com Bundler, Git, Redis, Memcached, PostgreSQL (super user _vagrant_ sem senha), MySQL (usuario/senha _root_/_root_), Nokogiri (libxml2 libxml2-dev libxslt1-dev), NodeJS, NPM e RVM.

Se quiser enfiar mais coisas no **up --provision**, edite o arquivo **bootstrap.sh** e adiciona os pacotes que tu quiser lá.. se der pau, nada que um _vagrant destroy_ não resolva.

E se quiser escolher outro ruby (aqui utilizo a 2.2.1), edite o arquivo **rvm.sh** e altere pra qual versão deseja.. pode instalar vários colocando um abaixo do outro, ou após todo o processo na VM mesmo com o clássico _rvm install x.x.x_

## Let's rock
crie a pasta **/vagrant** lá na home do seu mac:

    mkdir ~/vagrant

accesse ela

    cd ~/vagrant
    
e clona esse fork

    git clone https://github.com/marlosirapuan/rails-dev-box.git

entre na pasta gerada

    cd rails-dev-box

e agora siga esses passos:

## Provisionamento

montar a VM com um box do **ubuntu/trusty64**, se quiser outro basta editar no arquivo **Vagrantfile** em _config.vm.box_ e adicionar que box deseja ([aqui tem uma lista gigantes de boxes](http://www.vagrantbox.es/))

pra começar, execute o comando **dentro da pasta** _/rails-dev-box_:

    vagrant up --provision
    
vai demorar um inferno pra baixar o box, configurar etc.. mas num determinado momento ele vai mexer no seu _/etc/exports_ e vai pedir sua senha de admin (se não pedir, segue o baile)

    ==> default: Preparing to edit /etc/exports. Administrator privileges will be required...

entre com a senha pra seguir a execução; ao término entre na VM:

    vagrant ssh

tudo que foi definido no _bootstrap.sh_ e _rvm.sh_ já estará na VM instalado e rodando, agora ajuste algumas coisas pra funcionar legal:

## PostgreSQL
abra o **postgresql.conf** pra dar _trust_ nos hosts, portas etc

    sudo vim /etc/postgresql/9.3/main/postgresql.conf
    
procura por **listen_addresses** e adiciona na linha acima:

    listen_addresses = '*'

salve e agora abra o **pg_hba.conf** pra configurar ele também:

    sudo vim /etc/postgresql/9.3/main/pg_hba.conf 
    
e adiciona ao final do arquivo:

    host    all             all             0.0.0.0/0               trust

salve e restarta o postgresql: 

    sudo service postgresql restart

## MySQL
configurar o **my.cnf**

    sudo vim /etc/mysql/my.cnf
    
procura por **bind-address** e comenta ela:

    # bind-address            = 0.0.0.0

salve e restarta o mysql

    sudo service mysql restart

## Github

O esquema é o mesmo da [documentação](https://help.github.com/articles/generating-ssh-keys/)

    ssh-keygen -t rsa -C "seuemail@email.com"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub

cola o hash la nas definições de ssh do seu [github](https://github.com/settings/ssh)

## Comentários finais
No meu caso fiz esse processo após formatar o OSX e desde então funcionando normalmente. Se houver algum problema com **DHCP**, altere no arquivo **Vagrantfile**:

onde tiver:

    config.vm.network "private_network", type: "dhcp"
  
comente essa linha e adicione:

    config.vm.network :private_network, ip: "10.10.20.20"

IP fanta disponível e de acesso ao seu ambiente rails _10.10.20.20:3000_, mas se quiser incrementar mais pode redirecioná-los nos _hosts_ da sua máquina etc. Se funcionar com DHCP, tudo que você fazia via localhost/127.0.0.1 vai continuar funfando, do contrário, use o IP que definiu.

## Dúvidas????

* [Documentação Vagrant v2](http://docs.vagrantup.com/v2/)
* [StackOverflow](http://stackoverflow.com)
* [Google](http://google.com)

Cheers. :beers:
