# Use a imagem oficial do Nginx a partir do Alpine Linux
FROM nginx:alpine

# Remove o arquivo de configuração padrão que vem com a imagem
RUN rm /etc/nginx/conf.d/default.conf

# Copia seu arquivo de configuração local para o local correto dentro do contêiner
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copia os arquivos do seu site (HTML, CSS, JS) para a pasta que o Nginx serve
COPY . /usr/share/nginx/html