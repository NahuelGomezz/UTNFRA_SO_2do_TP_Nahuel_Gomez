#!/bin/bash
cd ~/UTN-FRA_SO_Examenes/202406/docker/
cat << 'FIN1' > index.html
<!DOCTYPE html>
<html>
<body>
    <h1>2do Parcial - Docker</h1>
    <p>Nombre: Nahuel Apellido: Gomez</p>
    <p>Division: 115</p>
    <p>IP: 10.0.2.15</p>
    <p>Distribucion: Ubuntu 22.04.5 LTS</p>
    <p>Cantidad de Cores: 2</p>
</body>
</html>
FIN1
cat << 'FIN2' > Dockerfile
FROM nginx
COPY index.html /usr/share/nginx/html/index.html
FIN2
docker build -t nahuelgomezz/web1-gomez:latest .
docker push nahuelgomezz/web1-gomez:latest
cat << 'FIN3' > run.sh
#!/bin/bash
docker run -d -p 8080:80 nahuelgomezz/web1-gomez:latest
FIN3
chmod +x run.sh
./run.sh
