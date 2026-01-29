#!/bin/bash/
echo "******************"
echo "УЗЛЫ:"
echo ""
docker node ls
echo "*****************"
echo "РАСПРЕДЕЛЕНИЕ СЕРВИСОВ ПО УЗЛАМ:"
echo ""
docker service ps -f "desired-state=running" --format "table {{.Name}}\t{{.Node}}\t{{.CurrentState}}" $(docker service ls -q) | sort
