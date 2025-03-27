# all: build up

# build:
# 	docker-compose -f srcs/docker-compose.yml build

# up:
# 	docker-compose -f srcs/docker-compose.yml up -d

# down:
# 	docker-compose -f srcs/docker-compose.yml down

# re: down up

# clean: down
# 	docker system prune -a --volumes

# .PHONY: all build up down re clean

# تنظیمات پایه
SRC_DIR = srcs
DATA_DIR = /home/$(USER)/data
DB_DATA = $(DATA_DIR)/mariadb
WP_DATA = $(DATA_DIR)/wordpress
ENV_FILE = $(SRC_DIR)/.env
COMPOSE_FILE = $(SRC_DIR)/docker-compose.yml
DOCKER_COMPOSE = docker-compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE)

build:
	$(DOCKER_COMPOSE) build

up:
	mkdir -p $(DB_DATA) $(WP_DATA)
	$(DOCKER_COMPOSE) up -d --force-recreate --build

down:
	$(DOCKER_COMPOSE) down

start:
	$(DOCKER_COMPOSE) start

stop:
	$(DOCKER_COMPOSE) stop

logs:
	$(DOCKER_COMPOSE) logs -f

clean:
	-docker stop $$(docker ps -qa)
	-docker rm $$(docker ps -qa)
	-docker rmi -f $$(docker images -qa)
	-docker volume prune -f
	-docker network prune -f
	-rm -rf $(DB_DATA)/* $(WP_DATA)/*
	
prune: clean
	docker system prune -a --volumes -f

re: clean up