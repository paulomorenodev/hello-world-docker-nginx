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

## Estrutura dos Arquivos

```
git_actions/
├── Dockerfile
├── nginx.conf
├── index.html
├── main.py
└── README.md
```