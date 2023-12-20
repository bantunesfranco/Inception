
all : install up

up :
	@docker-compose -f ./srcs/docker-compose.yml up

down :
	@docker-compose -f srcs/docker-compose.yml down

stop :
	@docker-compose -f srcs/docker-compose.yml stop

start :
	@docker-compose -f srcs/docker-compose.yml start

build :
	@docker-compose -f srcs/docker-compose.yml build

rebuild :
	@docker-compose -f srcs/docker-compose.yml up --build

prune:
	@rm -rf /home/bfranco/data/db/*
	@rm -rf /home/bfranco/data/wp/*
	@rm -rf /home/bfranco/data/nginx/*
	@docker system prune -af

ssh:
	ssh bfranco@localhost -p 2222

install:
	cat example_env > ./srcs/.env
	@mkdir -p /home/bfranco/data/db
	@mkdir -p /home/bfranco/data/wp
	@mkdir -p /home/bfranco/data/nginx

uninstall:
	@rm -rf ./srcs/.env
	@rm -rf /home/bfranco/data/db
	@rm -rf /home/bfranco/data/wp
	@rm -rf /home/bfranco/data/nginx

.PHONY: all up down build rebuild