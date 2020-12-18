#!/bin/bash

#######################################################################
#
#   nome do script: atualiza_centreon.sh
#   descricao: Este script foi feito para atualizar a versao 18.10 para 20.10.
#   da aplicação centreon.
#   autor: marcos antonio rodrigues da silva junior.
#   email: marcos.rodrigues@terceiro.rnp.br.
#   data de criacao: 02/12/2020.
#   chamado de criacao/motivo: N/A  (atualizacao da aplicacao para uma versao mais nova).
#   versao: 1.0
#
#########################################################################




# Variaveis Globais

DATE=`date '+%d/%m/%Y: ás %H:%M:%S'`
DIR_LOG=/tmp/log_atualiza_centreon.txt
touch /tmp/log_atualiza_centreon.txt
chmod 755 /tmp/log_atualiza_centreon.txt


# Funcoes
# testar erro nos comandos EXECUTADOS

function ERROR_COMMAND {
        if [ "$?" -ne "0" ]
        then
        echo " ##### ERRO NO ULTIMO COMANDO EXECUTADO EM : $DATE ##### " &>> $DIR_LOG
        exit 1
        else
        echo " ##### OK ..CONTINUANDO ATUALIZACAO...  ####"  &>> $DIR_LOG
        fi
}



echo "Qual etapa do procedimento do centreon deseja executar? (1) Atualizar pacotes de aplicacao de sistema operacional (2) Atualizar MariaDB de 10.1 para 10.2  (3) Atualizar MariaDB de 10.2 para 10.3"
read choice

if [ $choice = 1 ] 
			then

echo "########## INICIO  DO SCRIPT DE ATUALIZACAO DE APLICACAO E SISTEMA OPERACIONAL  EM:  $DATE ##########"  &>> $DIR_LOG

# Obs: o script precisa ser executado como root

echo "Fazendo backups de arquivos de configuracao"  &>> $DIR_LOG


# 2 Atualizando pacotes de aplicacao e repositorio centreon

echo " 2.2  Atualizando o repositorio centreon EM:  $DATE " &>> $DIR_LOG

 yum install -y centos-release-scl-rh &>>
 ERROR_COMMAND
 
 yum install -y http://yum.centreon.com/standard/20.10/el7/stable/noarch/RPMS/centreon-release-20.10-2.el7.centos.noarch.rpm
 ERROR_COMMAND

echo "# 2.3 Limpe o cache do yum EM:  $DATE  " &>> $DIR_LOG 

 yum clean all --enablerepo=*
 ERROR_COMMAND

echo "# 2.4  Atualizando todos os componentes os componentes EM:  $DATE" &>> $DIR_LOG  

 yum update centreon\*
 ERROR_COMMAND

echo "# 2.5 Atualizando a versão do PHP EM:  $DATE " &>> $DIR_LOG 

# 2.6 Atualizar timezone do PHP
# echo "date.timezone = Europe/Paris" >> /etc/opt/rh/rh-php72/php.d/50-centreon.ini

echo "# 2.7 Desabilitando o servico antigo e habilitando o servico novo do PHP EM:  $DATE "  &>> $DIR_LOG 

 systemctl disable rh-php71-php-fpm
 ERROR_COMMAND
 
 systemctl stop rh-php71-php-fpm
 ERROR_COMMAND
 
 systemctl enable rh-php72-php-fpm
 ERROR_COMMAND
 
 systemctl start rh-php72-php-fpm
 ERROR_COMMAND
 

echo "# 2.8 Instalando novo SSL EM:  $DATE  " &>> $DIR_LOG 

 yum install -y httpd24-mod_ssl
 ERROR_COMMAND
 

echo "# 2.9 Desabilitando o servico antigo e habilitando o servico novo do apache  EM:  $DATE " &>> $DIR_LOG 

 systemctl disable httpd
 ERROR_COMMAND
 
 systemctl stop httpd
 ERROR_COMMAND
 
 systemctl enable httpd24-httpd
 ERROR_COMMAND
 
 systemctl start httpd24-httpd
 ERROR_COMMAND
 


echo "# 2.10 Finalizando a atualizacao , recarregando o servidor apache EM:  $DATE" &>> $DIR_LOG 


 systemctl reload httpd24-httpd 
 ERROR_COMMAND
 

 echo  " !!! continue o processo de atualizacao na interface web !!!!" &>> $DIR_LOG 
 echo  " !!! ATUALIZE AS EXTENSION !!!!" &>> $DIR_LOG 
 echo  " !!! ATUALIZE A LICENCA DOS PLUGINS E OS PLUGIN PACKS MANAGER !!!!" &>> $DIR_LOG 

# 2.11 ativando o novo gerenciador de tarefas de centcore para gorgone

 systemctl stop centcore
 ERROR_COMMAND
 
 systemctl disable centcore
 ERROR_COMMAND
  
  
 systemctl enable gorgoned
 ERROR_COMMAND
 
 systemctl start gorgoned
 ERROR_COMMAND
 

# 2.12 Altere os direitos sobre os arquivos RRD de estatísticas executando o seguinte comando

 chown -R centreon-gorgone /var/lib/centreon/nagios-perf/*   
 ERROR_COMMAND
 


 echo " !!! Faca reload de todos os pollers do central via interface web !!!" &>> $DIR_LOG 

 exit 0 


	elif [ $choice = 2 ] 
			then
			
DB_VERSION=` mysql -V | cut -d " " -f6| cut -d - -f1`


	if [ $DB_VERSION == "10.1.36" ]
		   then
			

# Atualizando banco mariadb de 10.1 para 10.2

echo #INICIANDO O PROCESSO DE INSTALAÇÃO DO NOVO BANCO DE DADOS VERSÃO para 10.2 # &>> $DIR_LOG 

# Atualizar servidor MariaDB

# Atualize de 10.1 para 10.2
# Siga essas etapas resumidas para realizar a atualização 
# da maneira recomendada por MariaDB:

#Pare o serviço mariadb:

 systemctl stop mariadb
 ERROR_COMMAND
 

#Desinstale a versão 10.1 atual:

 rpm --erase --nodeps --verbose MariaDB-server MariaDB-client MariaDB-shared MariaDB-compat MariaDB-common
 ERROR_COMMAND
 

#Instale a versão 10.2:

 yum install MariaDB-server-10.2\* MariaDB-client-10.2\* MariaDB-shared-10.2\* MariaDB-compat-10.2\* MariaDB-common-10.2\*
 ERROR_COMMAND
 

# Inicie o serviço mariadb:

 systemctl start mariadb
 ERROR_COMMAND
 

# Inicie o processo de atualização do MariaDB:

 mysql_upgrade
 ERROR_COMMAND

fi

	elif [ $choice = 3 ]
			then
	

if [ $DB_VERSION == "10.2.36" ]
			then
			
			
			
# Atualizando banco mariadb de 10.2 para 10.3


echo "#INICIANDO O PROCESSO DE INSTALAÇÃO DO NOVO BANCO DE DADOS VERSÃO para 10.3 # " &>> $DIR_LOG 

# Atualize de 10.2 para 10.3
# Siga essas etapas resumidas para realizar a atualização
# da maneira recomendada por MariaDB:

# Pare o serviço mariadb:
 systemctl stop mariadb
 ERROR_COMMAND
 

# Desinstale a versão 10.2 atual:
 rpm --erase --nodeps --verbose MariaDB-server MariaDB-client MariaDB-shared MariaDB-compat MariaDB-common
 ERROR_COMMAND
 

# Instale a versão 10.3:

 yum install MariaDB-server-10.3\* MariaDB-client-10.3\* MariaDB-shared-10.3\* MariaDB-compat-10.3\* MariaDB-common-10.3\*
 ERROR_COMMAND
 

# Inicie o serviço mariadb:
 systemctl start mariadb
 ERROR_COMMAND
 

# Inicie o processo de atualização do MariaDB:

 mysql_upgrade
 ERROR_COMMAND
 

# Habilitar MariaDB na inicialização
# Execute o seguinte comando:

 systemctl enable mariadb
 ERROR_COMMAND
 
 fi
 

else
		echo "OPÇAO INCORRETA   - Escolha entre (1) Atualizar pacotes de aplicacao de sistema operacional (2) Atualizar MariaDB de 10.1 para 10.2  (3) Atualizar MariaDB de 10.2 para 10.3"

fi


########## FIM ##########
