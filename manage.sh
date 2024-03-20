#!/bin/bash

# Função para iniciar o docker-compose
start() {
    echo "Iniciando os containers..."
    docker-compose up -d
}

# Função para parar o docker-compose
stop() {
    echo "Parando os containers..."
    docker-compose down
}

# Função para executar um comando no serviço web
run_cmd() {
    echo "Executando comando no serviço web: $@"
    docker-compose run --rm --user=root  web "$@"
}

# Verifica o argumento passado para o script
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    run)
        shift 1
        run_cmd "$@"
        ;;
    *)
        echo "Uso: $0 {start|stop|run <comando>}"
        exit 1
        ;;
esac

exit 0
