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

#  EXECUTABLES = docker-compose docker node npm go
#  K := $(foreach exec,$(EXECUTABLES),\
#          $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

export FILENAME := kratos
export VERSION := 1.0.0
export PASSWORD := kratosBOY
export DB_NAME := kratos_pudgy

#DEV (who would have guessed that, lol.)
.PHONY: dev
dev: 
	./bin/${FILENAME} -c ./config/dev_kratos.yml serve --dev

#PROD 
.PHONY: start
start: 
	./bin/${FILENAME} -c ./config/kratos.yml serve 

 # Download a new version of Ory Kratos
.PHONY: download 
download:
	 cd ./bin && wget https://github.com/ory/kratos/releases/download/v${VERSION}/kratos_${VERSION}-linux_64bit.tar.gz && cd .

.PHONY: mig
dev_mig:
	./bin/${FILENAME} -c ./config/dev_kratos.yml migrate sql -y postgres://kratos:${PASSWORD}@127.0.0.1:5432/${DB_NAME}?sslmode=disable

.PHONY: migration
migration:
	./bin/${FILENAME} -c ./config/kratos.yml migrate sql -y postgres://kratos:${PASSWORD}@127.0.0.1:5432/${DB_NAME}?sslmode=disable