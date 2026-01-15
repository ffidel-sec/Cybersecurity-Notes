Socat es un _intermediario_, se usa para entablar redirecciones y nos sirve para que se comuniquen sistemas que no tienen visibilidad. Es mas simple de entender que chisel, son simplemente redirecciones de trafico. 

#### **Socat**
- Herramienta de **redirección**
- Conecta **un punto con otro**
- No crea red “nueva”
- Muy manual
- Se usa **una vez adentro**

---
### Uso:
En la maquina _intermediaria_, vamos  a ejecutar el siguiente comando por ejemplo:
```bash
./socat TCP-LISTEN:4343,fork TCP:192.168.111.1:80
```

_TCP-LISTEN:4343_ -> Se pone en escucha por el puerto 4343
_fork_ -> Hace que socat acepte múltiples conexiones.
_TCP_ -> Redirige el trafico que le llega a 192.168.111.1, en este caso, nuestra maquina como atacante.

Basicamente hace que lo que le llega al puerto 4343 lo manda a 192.168.111.1:80, por lo que nos tenemos que _poner en escucha_ por el 80 en la maquina atacante.
