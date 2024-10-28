docker stop $(docker ps -a -q )
docker rm $(docker ps -a -q )
#docker volume rm frappe_docker_sites
#docker volume rm frappe_docker_db-data

docker volume ls -q | grep -v "ukieri" | xargs -r docker volume rm

sudo systemctl stop docker

echo "docker compose -f marco.yml up --build"
echo " "
#docker compose -f marco.yml up --build

echo ""
echo ""
#echo "Run following command or build"
#echo "time docker compose -f  marco.yml up"
#docker compose -f  rai.yml up
#docker compose -f rai.yml up --build --no-cache
docker compose -f rai.yml build --no-cache

echo " "
echo " "
echo " "
echo " "
echo " "
echo " "
echo " "
echo " "
echo " "
echo " "
echo " "
echo "################################################################################ "
echo "                             Build Over "
echo "################################################################################ "
echo " "
echo " "


docker compose -f rai.yml up
