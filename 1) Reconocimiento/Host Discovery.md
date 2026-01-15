---
tags:
  - reconocimiento
  - redes
---

Hay varias formas de hacer un _Host Discovery_: 

Utilizando la herramienta que programamos llamada _ipfinder_ 

-------------

Con los siguiente comando de nmap:

```bash
nmap -sn 192.168.0.0/24
nmap -sP "192.168.0.*"
```

Creo que el mas recomendable es el 1ro.

-------------

Mediante un _escaneo ARP_:

```bash
arp-scan -I wlan0 --localnet
```

------------------------

Host Discovery con _Masscan_

Masscan es como un nmap pero mas chetado, _grandes rangos_

```bash
masscan -p22,80,8080,135,139,443,445 -Pn 192.168.0.0/16 --rate=10000
```

Ahi le pones los puertos que quieras y _va a buscar los equipos en la red que tengan dichos puertos abiertos_, no es tanto HostDiscovery
 
El _/16 es para entornos empresariales_, si se va a hacer el escaneo _en una red domestica metele /24_
A menos rate le des, mas posibilidades hay de que encuentre otros hosts

---
----
---
### Host Discovery en Windows

Tenemos el siguiente comando que hace un "descubrimiento pasivo", busca por equipos que eventualmente se comunicaron con el, toma info de la cache. No hace fuerza bruta:

```cmd
arp -a
```

O haciendo un escaneo piola con el siguiente oneliner:
```powershell
for /L %i in (1,1,254) do @ping -n 1 -w 200 192.168.1.%i | find "TTL="
```
