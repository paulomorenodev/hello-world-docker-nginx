# Hello World com Docker + Nginx

Este projeto cria uma imagem Docker simples com Nginx servindo uma página "Hello World" na porta 9090.

## Arquivos do Projeto

- `Dockerfile` - Configuração da imagem Docker
- `nginx.conf` - Configuração personalizada do Nginx
- `index.html` - Página HTML "Hello World"

## Como usar

### 1. Construir a imagem Docker

```bash
docker build -t hello-world-nginx .
```

### 2. Executar o container

```bash
docker run -d -p 9090:9090 --name hello-world hello-world-nginx
```

### 3. Acessar a página

Abra seu navegador e acesse:
```
http://localhost:9090
```

## Comandos úteis

### Parar o container
```bash
docker stop hello-world
```

### Remover o container
```bash
docker rm hello-world
```

### Ver logs do container
```bash
docker logs hello-world
```

### Listar containers em execução
```bash
docker ps
```

### Remover a imagem
```bash
docker rmi hello-world-nginx
```

## Características

- ✅ Nginx rodando na porta 9090
- ✅ Página HTML responsiva e estilizada
- ✅ Configuração otimizada do Nginx
- ✅ Compressão Gzip habilitada
- ✅ Headers de segurança
- ✅ Cache para arquivos estáticos
- ✅ Imagem baseada no Alpine (leve)

## Como criar um repositório no GitHub

### 1. Criar repositório no GitHub (via web)

1. Acesse [GitHub.com](https://github.com)
2. Faça login na sua conta
3. Clique no botão **"New"** ou **"+"** no canto superior direito
4. Preencha os dados:
   - **Repository name**: `hello-world-docker-nginx` (ou o nome que preferir)
   - **Description**: `Simple Hello World page served by Nginx in Docker container on port 9090`
   - Deixe como **Public** (ou Private se preferir)
   - **NÃO** marque "Add a README file" (já temos um)
   - **NÃO** marque "Add .gitignore" (já temos um)
5. Clique em **"Create repository"**

### 2. Conectar repositório local ao GitHub

```bash
# Adicionar o repositório remoto (substitua SEU_USUARIO pelo seu username do GitHub)
git remote add origin https://github.com/SEU_USUARIO/hello-world-docker-nginx.git

# Fazer push do código para o GitHub
git push -u origin main
```

### 3. Comandos Git úteis

```bash
# Ver status dos arquivos
git status

# Ver histórico de commits
git log --oneline

# Fazer alterações e commit
git add .
git commit -m "Descrição das alterações"
git push

# Clonar o repositório em outro local
git clone https://github.com/SEU_USUARIO/hello-world-docker-nginx.git
```

## Estrutura dos Arquivos

```
git_actions/
├── .gitignore
├── Dockerfile
├── nginx.conf
├── index.html
├── main.py
└── README.md
```