---
tags:
  - post-explotacion
  - reverse-shell
---

Diferentes tipos de binarios :

_Binario normal_ -> Se ejecuta con los permisos del usuario que lo lanza
_SUID (Linux)_    → se ejecuta con permisos del propietario (a menudo root).
_SGID (Linux)_   → se ejecuta con permisos del grupo.
_Scripts ejecutables_ → bash, python; útil si root los ejecuta con permisos inseguros.
_Binarios con vulnerabilidades_ → cualquier ejecutable compilado que pueda ser explotado (buffer overflow, PATH hijack, etc.).

El _SUID_ se ejecuta con permisos del propietario, normalmente root; un binario normal se ejecuta con los permisos del usuario que lo lanza.


Con el siguiente comando _buscamos permisos SUID_:

```bash
find / -perm -4000 2>/dev/null
```

Con el siguiente comando _buscamos permisos SGID_

```bash
find / -perm -2000 2>/dev/null
```

Una vez encontramos permisos SUID o SGID sospechosos, vamos a la pagina
https://gtfobins.github.io/
y buscamos el binario y la forma de [[Escalar Privilegios]]


_Cuales son los binarios sospechosos?_
* Se encuentra en /tmp o /home, los normales estan en /usr/bin o similares
* No son legitimos del sistema, como passwd, sudo o ping, por ejemplo
* Se modificaron recientemente