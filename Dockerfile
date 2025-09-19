# Use a imagem oficial do Nginx como base
FROM nginx:alpine

# Remover a configuração padrão do Nginx
RUN rm /etc/nginx/conf.d/default.conf

# Copiar nossa configuração personalizada
COPY nginx.conf /etc/nginx/conf.d/

# Copiar nossa página HTML para o diretório padrão do Nginx
COPY index.html /usr/share/nginx/html/

# Expor a porta 9090
EXPOSE 9090

# Comando para iniciar o Nginx
CMD ["nginx", "-g", "daemon off;"]