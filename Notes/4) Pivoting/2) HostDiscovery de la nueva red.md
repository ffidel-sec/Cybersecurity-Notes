Una vez conseguimos acceso a una maquina victima y vemos que tiene _acceso a una nueva red_, queremos listar las maquinas que estan dentro de esta nueva red. Para ello, tenemos varias formas:

_1)_ Podemos crear un script de bash que haga _HostDiscovery_ con el siguiente contenido:

```bash
#!/bin/bash
for i in $(seq 1 254); do
	timeout 2 bash -c "ping -c 1 192.168.111.$i" &>/dev/null && echo "[+] Host 192.168.111.$1 - ACTIVE" &
done; wait 
```

OOOOoo, si por ahi no nos reconoce nada por ICMP, que tenga el siguiente contenido:

```bash
#!/bin/bash
for i in $(seq 1 254); do
	for port in 21,22,23,25,53,80,110,143,443,445,3306,8080
		timeout 2 bash -c "echo '' > /dev/tcp/192.168.111.$i/$port" &>/dev/null && echo "[+] Host 192.168.111.$1:$port - OPEN" &
done; wait 
```