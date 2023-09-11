
all: up

up:
	mkdir /home/bfranco/data
	cd srcs && docker compose up 

down:
	cd srcs && docker compose down

build:
	cd srcs && docker compose build

rebuild:
	cd srcs && docker compose build --no-cache

ssh:
	echo 1234 | ssh bfranco@localhost -p 2222

.PHONY: all up down build rebuild