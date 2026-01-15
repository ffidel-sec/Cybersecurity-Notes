#Inyeccion
### _LDAP_ --> Ligthweigth Directory Access Protocol / Protocolo ligero de acceso a directorio.

https://www.profesionalreview.com/2019/01/05/ldap/

Se trata de un conjunto de protocolos de licencia abierta que son utilizados para acceder a la informacion que esta almacenada de forma centralizada en una red. Este protocolo se utiliza a nivel de aplicacion para acceder a los servicios de directorio remoto

Un directorio LDAP es como una **base de datos**, son esquemas verticales donde se almacena informacion y registros de una empresa, que se veria mas o menos asi

```js

dc=techcorp,dc=com
   ├── ou=Ventas
   │     ├── uid=juan.perez
   │     │     ├── cn: Juan Pérez
   │     │     ├── mail: juan.perez@techcorp.com
   │     │     ├── title: Vendedor
   │     │     └── phone: +54 9 11 1234-5678
   │     ├── uid=ana.gomez
   │     │     ├── cn: Ana Gómez
   │     │     ├── mail: ana.gomez@techcorp.com
   │     │     ├── title: Vendedora
   │     │     └── phone: +54 9 11 8765-4321
   │     └── ...
   ├── ou=RecursosHumanos
   │     ├── uid=laura.martinez
   │     │     ├── cn: Laura Martínez
   │     │     ├── mail: laura.martinez@techcorp.com
   │     │     ├── title: Especialista en RRHH
   │     │     └── phone: +54 9 11 1122-3344
   │     ├── uid=pedro.rodriguez
   │     │     ├── cn: Pedro Rodríguez
   │     │     ├── mail: pedro.rodriguez@techcorp.com
   │     │     ├── title: Analista de RRHH
   │     │     └── phone: +54 9 11 5566-7788
   |     |
		 └── cn=Impresora-Recepcion
            ├── objectClass: printer, device
            ├── cn: Impresora-Recepcion
            ├── printerURI / labeledURI: lpd://10.0.0.45/queue
            ├── printerMakeAndModel: HP LaserJet Pro M404
            ├── location: Planta Baja - Recepción
            ├── description: Impresora compartida para recepción
            ├── owner: uid=laura.martinez,ou=Recursos,dc=techcorp,dc=com
            └── serialNumber: SN12345678
   
   ├── ou=IT
   │     ├── uid=carla.lopez
   │     │     ├── cn: Carla López
   │     │     ├── mail: carla.lopez@techcorp.com
   │     │     ├── title: Ingeniera de Sistemas
   │     │     └── phone: +54 9 11 9988-7766
   │     ├── uid=jorge.mendoza
   │     │     ├── cn: Jorge Mendoza
   │     │     ├── mail: jorge.mendoza@techcorp.com
   │     │     ├── title: Soporte Técnico
   │     │     └── phone: +54 9 11 2233-4455
   │     └── ...
```

_dn (Distinguised Name / Nombre Distinguido)_ -->   Es la ruta absoluta de algun elemento del directorio, por ej:  `uid=carla lopez,ou=IT,dc=empresa,dc=com`
	_dc (Domain Component)_ --> Cada parte del dominio, separado por los puntos
		_ou (Organizational Unit)_ --> Sirve para agrupar objetos dentro de un directorio
			_uid (UserID)_ --> Identificador unico del usuario dentro del directorio, por lo general es el nombre
				_cn (Common Name)_ --> Nombre comun o completo del usuario
					

-------
Si vemos que un servidor tiene el puerto 389 abierto (_LDAP_), podemos hacerle un escaneo de scripts posibles para LDAP:

```bash
locate .nse | grep "ldap"
```

Con ese comando vemos todos los scripts de ldap disponibles y podemos llegar a enumerar rutas o algunos usuarios 

```bash
nmap --script ldap\* -p389 localhost 
```

-------------
_ldapsearch_ sirve para consultar informacion dentro de un directorio **LDAP**, si nmap nos detecta algo, lo podemos especificar aca. 

```bash
ldapsearch -H ldap://localhost -x -D "cn=admin,dc=empresa,dc=com" -w "mi_clave" -b "dc=empresa,dc=com" "(uid=juan)"`
```

_-x_ --> Simple autentication, es anonima, si el servidor lo permite podemos no adjuntar creds
_-D_ --> Usuario
_-w_ --> Contrasena
_-H_ --> Especificar el servidor ldap
_-b_ --> Base de busqueda, donde empezar en el arbol

-----------
### Como son las consultas LDAP?

Las consultas LDAP son entre parentesis y usan pares atributo=valor, por ejemplo -> `(uid=juan)`
Peeero, tambien se le pueden meter filtros que son como "expresiones regulares", como el * , que es como un "comodin" en ldap : `(uid=j*)` -> `Juan`

Supongamos que un formulario tiene la siguiente query: 

```
(&(cn=INPUT_USUARIO)(userpassword=password))
```

Si en el input pones: 
`admin))%00` --> Estas cerrando la query y "comentando" (q no es un comentario pero anula lo que sigue) y cerras los parentesis, por lo tanto la siguiente porcion de codigo no se ejecuta.
`admin)(mail=*))%00` --> Estas agregando un atributo a la consulta. se puede fuzzear eso para reconocer todos los atributos --> 

```bash
ffuf -w wordlist -d "admin)(FUZZ=*))%00" -X POST -u https://google.com`
```





