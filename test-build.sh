#!/bin/bash

# Script para testar o build local antes do deploy
# Use: ./test-build.sh

set -e

echo "🧪 Testando build local do Docker..."
echo "========================================"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

IMAGE_NAME="hello-world-nginx-test"
CONTAINER_NAME="hello-world-test"
PORT="9091" # Porta diferente para não conflitar

echo -e "${BLUE}📦 Construindo imagem Docker...${NC}"
docker build -t $IMAGE_NAME .

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Build realizado com sucesso!${NC}"
else
    echo -e "${RED}❌ Erro no build!${NC}"
    exit 1
fi

echo -e "${BLUE}🧹 Limpando containers anteriores...${NC}"
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

echo -e "${BLUE}🚀 Iniciando container de teste...${NC}"
docker run -d \
    --name $CONTAINER_NAME \
    -p $PORT:9090 \
    $IMAGE_NAME

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Container iniciado com sucesso!${NC}"
else
    echo -e "${RED}❌ Erro ao iniciar container!${NC}"
    exit 1
fi

# Aguardar um pouco para o nginx inicializar
echo -e "${YELLOW}⏳ Aguardando nginx inicializar...${NC}"
sleep 3

# Testar se está respondendo
echo -e "${BLUE}🌐 Testando conectividade...${NC}"
if curl -s http://localhost:$PORT > /dev/null; then
    echo -e "${GREEN}✅ Aplicação respondendo corretamente!${NC}"
    echo -e "${GREEN}🌐 Acesse: http://localhost:$PORT${NC}"
else
    echo -e "${RED}❌ Aplicação não está respondendo!${NC}"
    echo -e "${YELLOW}📋 Logs do container:${NC}"
    docker logs $CONTAINER_NAME
    exit 1
fi

echo ""
echo -e "${GREEN}🎉 Teste local concluído com sucesso!${NC}"
echo -e "${BLUE}📋 Informações:${NC}"
echo -e "   🐳 Imagem: $IMAGE_NAME"
echo -e "   📦 Container: $CONTAINER_NAME"
echo -e "   🌐 URL: http://localhost:$PORT"
echo ""
echo -e "${YELLOW}🛠️  Comandos úteis:${NC}"
echo -e "   Ver logs: ${BLUE}docker logs $CONTAINER_NAME${NC}"
echo -e "   Parar: ${BLUE}docker stop $CONTAINER_NAME${NC}"
echo -e "   Remover: ${BLUE}docker rm $CONTAINER_NAME${NC}"
echo -e "   Limpar imagem: ${BLUE}docker rmi $IMAGE_NAME${NC}"
echo ""
echo -e "${GREEN}✅ Pronto para deploy na OCI!${NC}"