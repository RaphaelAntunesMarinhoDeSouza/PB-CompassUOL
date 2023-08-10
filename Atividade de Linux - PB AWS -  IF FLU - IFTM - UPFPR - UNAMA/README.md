# Atividade_de_Linux_AWS

## Requisitos AWS:
- Gerar uma chave pública para acesso ao ambiente;
- Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small, 16 GB SSD);
- Gerar 1 elastic IP e anexar à instância EC2;
- Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP)

## Requisitos no Linux:
- Configurar o NFS entregue;
- Criar um diretorio dentro do filesystem do NFS com seu nome;
- Subir um apache no servidor - o apache deve estar online e rodando;
- Criar um script que valide se o serviço esta online e envie o resultado da validação para o seu diretorio no nfs;
- O script deve conter - Data HORA + nome do serviço + Status + mensagem personalizada de ONLINE ou offline;
- O script deve gerar 2 arquivos de saída: 1 para o serviço online e 1 para o serviço OFFLINE;
- Preparar a execução automatizada do script a cada 5 minutos.


# AWS 

## Pré-requisitos
Antes de começar com a criação da instancia foram feitos os passos a seguir:
- Criar uma VPC 
- Criar uma subnet publica 
- Criar um internet gateway 
- Associar as ações anteriores.

## Passo a passo da execução

### Criando a instância EC2 
Acessando a console da AWS procure pelo serviço de **EC2**, vá em **Instances**, posteriomente clique em **Launch instances**.

Com a janela de criação de instâncias EC2 aberta, configurar Key e Value da instância (Name, Project e CostCenter) para instâncias e volumes.
<div align="center">
<img src="https://github.com/RaphaelAntunesMarinhoDeSouza/Images/blob/main/EC2/Captura%20de%20ecr%C3%A3%20de%202023-08-04%2008-50-06.png" width="500px">
</div>

Selecionar a imagem (Sistema operacional) da máquina virtual (Amazon Linux 2)
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/251817121-4051bf6c-413b-48f9-bd64-a8d75ecccae5.png" width="650px">
</div>

Escolher o tipo da instância, neste caso a escolhida foi t2.micro, conforme consta no pdf de intruções aos bolsistas
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/251818219-ba5b8f78-1b0e-456e-9238-03ac9b8b5a31.png" width="700px">
</div>

Selecionar o par de chaves, caso não possua um par de chaves será necessário criar um novo par de chaves.
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252471375-189fbc8d-e018-46f6-bac1-74ccad25a5fa.png" width="600px">
</div>

Editar **Network settings** conforme solicitado. Deve-se ainda associar a VPC criada anteriormente.
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252473263-3c2dc9d1-b45d-42e3-b754-c4c168cf09b0.png
" width="600px">
</div>
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252473262-cb4a3e0b-020c-48c2-a694-bf2d1ce67c44.png" width="600px">
</div>
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252473260-b55c0e04-fd43-4e18-99c8-fba47e48a38b.png" width="600px">
</div>
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252473258-eae2f646-207b-4f7c-bb9b-addb36c1ab9c.png" width="600px">
</div>
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252473257-9134940e-b908-47a3-81b8-1e51708e935f.png" width="600px">
</div>

Na aba **Configure storage** definir o volume em 16GB e gp2 (General purpose SSD).
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252475470-3600953b-8529-4d44-8618-a51756c40cae.png" width="600px">
</div>

Posteriormente, basta clicar no botão **Launch instance** para finalizar a criação da instância EC2.

### Criando exando 1 elastic IP à instância EC2 
Acessando a console da AWS procure pelo serviço de **EC2**, vá em **Elastic IP addresses**, posteriomente clique em **Allocate Elastic IP addresses**.
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252481203-2aa32b78-97f2-420b-aedc-4f8ad9456e07.png" width="1050px">
</div>

Escolha a região desejada, mesma da instância EC2, clique no botão de **Allocate** e a assim um Elastic IP será gerado.
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252484421-abbab3c4-e316-445b-80e8-312922dc8ed7.png" width="650px">
</div>

A proxima etapa é associar a instâmcia EC2 criada anteriormente ao Elastic IP gerado, para isso basta selecionar o Elastic IP gerado, clicar no botão **Actions** e em **Associate Elastic IP address**.
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252487699-ee8881fd-d347-4b42-b9b1-1f015f86cf6d.png" width="300px">
</div>

Nesta nova aba selecione a opção **Instance**, no campo **instance** escolha a instância criada anteriormente e no campo **Private IP address** escolha o ip privado.
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252495023-600526d8-3497-4f90-a8d1-95c25093ba04.png" width="600px">
</div>

# LINUX 

## Pré-requisitos
Antes de começar com as configurações do linux foram feitos os passos a seguir:
- Instalar o PuTTY
- Acessar o PuTTY ir no menu lateral esquerdo, clicar em **Connection**, depois em **SSH**, em **Auth** e selecionar a chave que utilizamos no momento da criação da instância
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252500068-9d000af6-9618-4558-ba12-5a1437ff4f1d.png" width="550px">
</div>  
No menu lateral esquerdo clicar em Session e inserir ec2-user@ + o IP público da instância EC2.
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252695915-f4fc98c0-b78a-4833-8b8d-dabb4a8b0c30.png" width="550px">
</div>
Assim que fizer isso o ambiente estará pronto para as configurações.
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252718530-a995ff51-dbd8-4b5b-b673-64f3232ca99b.png" width="500px">
</div>

### Abrindo novamente a console AWS, procure por EFS
A AWS diz que: "O Amazon Elastic File System (Amazon EFS) fornece um sistema de arquivos NFS elástico simples, escalável e totalmente gerenciado para uso com serviços em nuvem da AWS e recursos locais. Ele foi projetado para escalar sob demanda para petabytes sem interromper aplicativos, crescendo e diminuindo automaticamente à medida que você adiciona e remove arquivos, eliminando a necessidade de provisionar e gerenciar capacidade para acomodar o crescimento. O Amazon EFS foi projetado para fornecer acesso compartilhado massivamente paralelo a milhares de instâncias do Amazon EC2, permitindo que suas aplicações alcancem altos níveis de taxa de transferência agregada e IOPS com latências consistentemente baixas."
Clique em **Create file system**
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252731356-5893daae-5b3b-4522-a20d-2675278479d0.png" width="350px">
</div>


Escolha o nome do EFS, a VPC e clique em **create**
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252753297-ef668b94-2756-47d4-9968-7bd8d716f8e6.png" width="500px">
</div>

Agora com EFS criado, clique no ID do EFS
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252754288-0298ff9e-452f-4533-acfc-1a2f7bcded88.png" width="700px">
</div>

Vá até a aba **Access points** e em seguida clique em **Create access points**
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252754434-ad99723a-4eb1-46f7-ac72-b0b0232274bb.png" width="700px">
</div>

Crie um nome para o ponto de acesso e clique em **Create access points**
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252754580-e7ab0610-1d2f-4a58-b48d-d2e8a59bcd4b.png" width="700px">
</div>
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252754781-a6e22cd9-f7ff-4140-8b39-2ac71f90ee11.png" width="700px">
</div>

Va até a aba **Network** e em seguida clique em **Manage**
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252754942-221f19ba-9584-472b-87e4-a184b8dab4a7.png" width="700px">
</div>

Altere o security group para o mesmo utilizado na instância EC2
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252755094-2f9d9296-363c-4934-baa4-09a3827a5f06.png" width="700px">
</div>

Agora basta copiar o **DNS NAME**
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/252755416-b60a083c-1679-4e95-9346-e597cab83ecf.png" width="700px">
</div>

Voltando para o PuTTy com a instância EC2 já conectada execute os seguintes comandos:
- ```sudo -i```
- ```yum -y install amazon-efs-utils```
- ```mkdir efs```
- ```mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 10.0.1.247:/ efs```

##### Os comandos acima devem ser executados também em um instância EC2 secundária.

Na EC2 principal execute os comando:
- ```mkdir efs/raphael```
                
Testando a conexão:
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/253064357-2f34a327-4914-4a27-a310-ace7166fb8e6.png" width="700px">
</div>                

### Subindo o Apache no servidor
Instalando o Apache:
- ```yum update```
- ```yum install httpd```
- ```systemctl start httpd```
- ```systemctl status httpd```
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/253067506-a772bfa8-6ad6-45d9-b9c0-57dced598a2b.png" width="700px">
</div>

Agora jogando o IP publico da instância EC2 no browser
<div align="center">
<img src="https://user-images.githubusercontent.com/138892189/253068026-3188ca09-55a8-4d34-b0a2-ff24a2c6807b.png" width="1000px">
</div>

### Criando script de validação do Apache 
Criando o script:
- ```vi status.sh```
##### Edite clicando em  ```i``` e insira o script

Execute o comando para habilitar as permissões necessárias para o script:
- ```chmod 777 status.sh```

Com o comando ```./status.sh``` execute o scrit de comando, até aqui o script escreve uma nova linha no arquivo com o status do apache toda vez que é executado

### Automatização do script a cada 5 minutos
Para automatizar o script foi 

 Execute o comando `crontab -e`
- Adicione a seguinte linha de código::
    ```bash
    */5 * * * * /home/ec2-user/status.sh
    ```
- Salve o arquivo
- Execute o comando `crontab -l` para verificar se foi configurado corretamente.

Para executar execute o programa:
```systemctl start crond```

Para verificar o status execute o comando:
```systemctl status crond```
