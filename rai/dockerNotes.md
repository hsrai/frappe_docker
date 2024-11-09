frappe@cc:~/frappe_docker$ docker ps
CONTAINER ID   IMAGE                     COMMAND                  CREATED          STATUS          PORTS                                                                      NAMES
896f46028cb8   jwilder/nginx-proxy:1.6   "/app/docker-entrypo…"   44 minutes ago   Up 44 minutes   0.0.0.0:80->80/tcp, :::80->80/tcp, 0.0.0.0:443->443/tcp, :::443->443/tcp   fm_global-nginx-proxy
21d283f55f69   mariadb:10.6              "docker-entrypoint.s…"   44 minutes ago   Up 44 minutes   3306/tcp                                                                   fm_global-db

Runnung when on website is running using fm or docker up


 2321  time docker compose -f  gne.yml up -d
 2328  sudo cp /etc/letsencrypt/live/exp.gndec.ac.in/fullchain.pem .
 2329  sudo cp /etc/letsencrypt/live/exp.gndec.ac.in/privkey.pem .
 2331  sudo chown frappe:frappe fullchain.pem privkey.pem 
 2333  docker cp fullchain.pem fm_global-nginx-proxy:/etc/nginx/certs/exp.gndec.ac.in.crt
 2334  docker cp privkey.pem fm_global-nginx-proxy:/etc/nginx/certs/exp.gndec.ac.in.key
 2335  joe exp.gndec.ac.in.conf


server {
    listen 80;
    server_name exp.gndec.ac.in;

    location / {
        proxy_pass http://frappe_docker-frontend-1:8080;  # Change to match your backend
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

server {
    listen 443 ssl;
    server_name exp.gndec.ac.in;

    ssl_certificate /etc/nginx/certs/exp.gndec.ac.in.crt;
    ssl_certificate_key /etc/nginx/certs/exp.gndec.ac.in.key;

    location / {
        proxy_pass http://frappe_docker-frontend-1:8080;  # Adjust to match your backend
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}




 2336  docker cp exp.gndec.ac.in.conf fm_global-nginx-proxy:/etc/nginx/conf.d
 2341  docker network connect frappe_docker_default fm_global-nginx-proxy
 2343  docker exec -it fm_global-nginx-proxy nginx -s reload
