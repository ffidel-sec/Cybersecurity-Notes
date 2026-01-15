WebDAV es un _protocolo_ que nos permite guardar archivos, editarlos, moverlos y compartirlos en un servidor web de manera remota. WebDAV agrega funciones de **explorador de archivos** sobre _HTTP/S_. Permite subir, borrar, mover, editar y listar archivos en un servidor web.
#### Por lo que averigue, esta vulnerabilidad esta casi obsoleta.
--------
_1ro_ -> Ver si corre webDAV atras:

```bash
nmap -p80,443 --script http-webdav-scan 192.168.0.0
```

-----------
Si encontramos que esta abierto podemos hacer el siguiente comando para enumerar la pagina, detectar metodos WebDAV, intentar subir archivos con distintas extensiones, etc:

```zsh
davtest -url http://localhost -auth admin:richard
```

_-auth admin:richard_ -> Se agrega si pide login

------
Se veria asi una respuesta exitosa de davtest:

![Screenshot](Images/webdav_enum1.png)

