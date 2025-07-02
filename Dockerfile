# Usar uma imagem base do Python
FROM python:3.13.5-alpine3.22

# Definir variáveis de ambiente para boas práticas em Python com Docker
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copiar o arquivo de dependências primeiro para aproveitar o cache do Docker.
# A camada de dependências só será reconstruída se o requirements.txt mudar.
COPY requirements.txt .

# Instalar as dependências do projeto
RUN pip install --no-cache-dir -r requirements.txt

# Copiar todo o código da aplicação para o diretório de trabalho no contêiner
COPY . .

# Expor a porta em que a aplicação irá rodar (Uvicorn usa 8000 por padrão)
EXPOSE 8000

# Comando para iniciar a aplicação quando o contêiner for executado.
# Usamos --host 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]


