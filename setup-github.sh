#!/bin/bash

# Script para configurar e publicar o projeto no GitHub
# Use: ./setup-github.sh SEU_USUARIO_GITHUB

if [ $# -eq 0 ]; then
    echo "❌ Uso: $0 SEU_USUARIO_GITHUB"
    echo "Exemplo: $0 paulomorenodev"
    exit 1
fi

GITHUB_USER=$1
REPO_NAME="hello-world-docker-nginx"

echo "🚀 Configurando repositório GitHub..."
echo "👤 Usuário: $GITHUB_USER"
echo "📁 Repositório: $REPO_NAME"
echo ""

# Verificar se já existe um remote origin
if git remote get-url origin > /dev/null 2>&1; then
    echo "⚠️  Remote 'origin' já existe. Removendo..."
    git remote remove origin
fi

# Adicionar o remote
echo "🔗 Adicionando remote origin..."
git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git

echo ""
echo "✅ Configuração concluída!"
echo ""
echo "📋 Próximos passos:"
echo "1. Acesse: https://github.com/$GITHUB_USER"
echo "2. Clique em 'New repository'"
echo "3. Nome do repositório: $REPO_NAME"
echo "4. Descrição: Simple Hello World page served by Nginx in Docker container on port 9090"
echo "5. NÃO marque 'Add a README file' nem 'Add .gitignore'"
echo "6. Clique em 'Create repository'"
echo ""
echo "🚀 Depois execute:"
echo "   git push -u origin main"
echo ""
echo "🌐 Seu repositório estará em:"
echo "   https://github.com/$GITHUB_USER/$REPO_NAME"