docker stop $(docker ps -a -q --filter volume=frappe_docker_sites)
docker rm $(docker ps -a -q --filter volume=frappe_docker_sites)
docker volume rm frappe_docker_sites
#docker volume rm frappe_docker_db-data

sudo systemctl stop docker

echo "docker compose -f marco.yml up --build"
echo " "
#docker compose -f marco.yml up --build

echo ""
echo ""
echo "Run following command or build"
echo "time docker compose -f  marco.yml up"
#docker compose -f  rai.yml up
#docker compose -f rai.yml up --build --no-cache
docker compose -f rai.yml build --no-cache
docker compose -f rai.yml up
