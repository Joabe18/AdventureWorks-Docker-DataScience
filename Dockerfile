FROM jupyter/datascience-notebook:latest

USER root

# 1. Instala ferramentas de download essenciais
RUN apt-get update && apt-get install -y gnupg2 curl

# 2. Adiciona a chave oficial de segurança da Microsoft
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# 3. Adiciona o repositório correto do SQL Server para o Ubuntu do container
RUN curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

# 4. Atualiza a lista do sistema e instala o driver ODBC
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev

# 5. Retorna para o usuário padrão do Jupyter por segurança
USER jovyan

# 6. Garante as bibliotecas Python atualizadas e fixa o NumPy na versão 1.x
RUN pip install --no-cache-dir "numpy<2" pyodbc sqlalchemy

