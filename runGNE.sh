docker stop $(docker ps -a -q )
docker ps -a -q | grep -v "ukieri" | \
        grep -v "mainie" | grep -v "rkmar" | \
        xargs -r docker rm
# docker rm $(docker ps -a -q )
docker volume ls -q | grep -v "ukieri" | grep -v "mainie" | grep -v "rkmar" | xargs -r docker volume rm
sudo systemctl stop docker
docker compose -f  gne.yml up
# docker compose -f  gne.yml up -d // -d: up in detached mode
# docker compose -f  gne.yml down  // stopping docker running in detached mode

