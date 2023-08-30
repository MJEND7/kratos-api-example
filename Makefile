# -----------------------------------------------------------------------------
# MIT License
# -----------------------------------------------------------------------------
# Copyright (c) Markuss Cowburn <mjend.dev@gmail.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# -----------------------------------------------------------------------------
# Date: 2023-08-30
# -----------------------------------------------------------------------------

SHELL=/bin/bash -o pipefail

# List of required executables
REQUIRED_EXECUTABLES = docker-compose docker node npm go
CHECK_EXECUTABLES := $(foreach exec,$(REQUIRED_EXECUTABLES),\
	$(if $(shell which $(exec)),some string,$(error "$(exec) not found in PATH")))

# YML
export FILENAME := kratos
export VERSION := 1.0.0
# DB
export DB_YOUR_NAME := kratos
export DB_PASSWORD := kratosBOY # should change (you get the meme right) 😅
export DB_NAME := kratos
export DB_LOCATION := 127.0.0.1
export DB_PORT := 5432

# Target for running the development server
.PHONY: dev
dev: 
	./bin/${FILENAME} -c ./config/dev_kratos.yml serve --dev

# Target for starting the production server
.PHONY: start
start: 
	./bin/${FILENAME} -c ./config/kratos.yml serve 

# Target for downloading a new version of Ory Kratos
.PHONY: download 
download:
	cd ./bin && wget https://github.com/ory/kratos/releases/download/v${VERSION}/kratos_${VERSION}-linux_64bit.tar.gz && cd ..

# Target for running database migration in development
.PHONY: dev_mig
dev_mig:
	./bin/${FILENAME} -c ./config/dev_kratos.yml migrate sql -y postgres://${DB_YOUR_NAME}:${DB_PASSWORD}@${DB_LOCATION}:${DB_PORT}/${DB_NAME}?sslmode=disable

# Target for running database migration in production
.PHONY: migration
migration:
	./bin/${FILENAME} -c ./config/kratos.yml migrate sql -y postgres://${DB_YOUR_NAME}:${DB_PASSWORD}@${DB_LOCATION}:${DB_PORT}/${DB_NAME}?sslmode=disable

# Install and Setup PostgreSQL
.PHONY: setup-postgres
setup-postgres:
	sudo apt install postgresql postgresql-contrib -y
	sudo -i -u postgres createdb ${DB_NAME}
	sudo -i -u postgres psql -c "ALTER SYSTEM SET password_encryption = 'scram-sha-256'; SELECT pg_reload_conf();"
	sudo -i -u postgres psql -c "CREATE USER ${DB_YOUR_NAME} PASSWORD '${DB_PASSWORD}';"
	sudo -i -u postgres psql -c "GRANT CONNECT ON DATABASE ${DB_NAME} to ${DB_NAME};"
	echo "host    all             all             ${DB_LOCATION}/32            scram-sha-256" | sudo tee -a /etc/postgresql/12/main/pg_hba.conf
	sudo service postgresql restart
	psql -U ${DB_NAME} -W -h ${DB_LOCATION}


# Info target to display available commands
.PHONY: info
info:
	@echo "Available Makefile commands:"
	@echo "  make dev            : Run the development server"
	@echo "  make start          : Start the production server"
	@echo "  make download       : Download a new version of Ory Kratos"
	@echo "  make dev_mig        : Run database migration in the development environment"
	@echo "  make migration      : Run database migration in the production environment"
	@echo "  make setup-postgres : Install and set up PostgreSQL for your project"
