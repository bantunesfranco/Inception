
all : up

up :
	mkdir -p /workspaces/codespaces-blank/Inception/db
	mkdir -p /workspaces/codespaces-blank/Inception/wp
	@docker-compose -f ./srcs/docker-compose.yml up -d

down :
	@docker-compose -f srcs/docker-compose.yml down

stop :
	@docker-compose -f srcs/docker-compose.yml stop

start :
	@docker-compose -f srcs/docker-compose.yml start

build :
	@docker-compose -f srcs/docker-compose.yml build

rebuild :
	@docker-compose -f srcs/docker-compose.yml up --build -d

ssh:
	echo 1234 | ssh bfranco@localhost -p 2222

.PHONY: all up down build rebuild