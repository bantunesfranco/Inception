
all : up

up :
	@mkdir -p /home/bfranco/data/db
	@mkdir -p /home/bfranco/data/wp
	@docker-compose -f ./srcs/docker-compose.yml up -d

down :
	@rm -rf /home/bfranco/data/db
	@rm -rf /home/bfranco/data/wp
	@docker-compose -f srcs/docker-compose.yml down

stop :
	@docker-compose -f srcs/docker-compose.yml stop

start :
	@docker-compose -f srcs/docker-compose.yml start

build :
	@docker-compose -f srcs/docker-compose.yml build

rebuild :
	@docker-compose -f srcs/docker-compose.yml up --build -d

prune:
	@rm -rf /home/bfranco/data/db
	@rm -rf /home/bfranco/data/wp
	@docker system prune -af

ssh:
	echo 1234 | ssh bfranco@localhost -p 2222

.PHONY: all up down build rebuild