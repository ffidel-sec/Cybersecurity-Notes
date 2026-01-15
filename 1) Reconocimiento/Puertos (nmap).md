---
tags:
  - reconocimiento
  - herramienta
  - redes
---

```bash
sudo nmap -p- 65525 --open -sS --min-rate 5000 -vvv -n 10.10.16.81
```

**Parametros interesantes para la evasion de firewall**

_-f_ --> Este parametro sirve para fragmentar el paquete, con la finalidad de evadir el firewall. Ya que a veces, el firewall espera un paquete concreto pero con este parametro evadimos
_--mtu 8_ --> Otro parametro para eludir firewall, que tambien fragmenta el paquete por lo que tengo entendido. el numero si o si tiene que ser multiplo de 8
_-D 192.168.0.12, 192.168.0.187, 192.168.0.43_---> Este comando es muy interesante, ya que agrega otra/s ip a la peticion, es decir, yo le puedo meter 500 IPs distintas y tu ip se camufla entre todas las otras que le pongas


Por defecto, nmap abre un puerto aleatorio para realizar la peticion hacia la victima, pero a lo mejor el firewall de la victima tiene una white list de puertos que pueden realizar solicitudes, entonces, con el siguiente comando, _manipulamos el puerto que envia la solicitud_, y quizas si esta en la white list nos deja hacer la peticion:

```bash
nmap --source-port 53 192.168.0.0 ---> 53 por ejemplo, puede ser cualquiera
```

Otro aspecto a tener en cuenta para evasion de firewall, es la _longitud del paquete_, ya que algunos firewalls reconocen el tamano del paquete y los tienen como en una black-list. Se modifica con:

```bash
nmap --data-length 21 ---> 21 se le suma al tamano del paquete
```

Otra cosa importante que se puede hacer con nmap es _cambiar la direccion mac_, quizas no sea lo optimo ya que puede no reconocer puertos.
Se hace con el siguiente comando:

```bash
nmap --spoof-mac Dell                              
nmap --spoof-mac 00:11:22:33:44:55:66 
```


------------
**Uso de scripts de nmap:**

Con este comando listamos todos los _scripts_ disponibles

```bash
find / -name "*.nse" 2>/dev/null 
```

Con este listamos las _categorias_

```bash
find / -name "*.nse" 2>/dev/null | xargs grep "categories" -n 
```

Ubicacion de los scripts --> _/usr/share/nmap/scripts/_

```bash
nmap -p80 --script http-enum 192.168.0.1
nmap -p- --script "vuln or safe or discovery or auth" 192.168.0.1
```


Estas son las categorias _mas conocidas_:

_default_ -> Los scripts mas usados y conocidos, es como hacer -sC
_intrusive_ -> Estos scripts hacen pruebas mas ruidosas y agresivas e incluso puede incluir explotacion
_vuln_ -> Busca vulnerabilidades conocidas, a veces incluso envia payloads para verificar existencia, medianamente ruidoso
_safe_ -> Hace comprobaciones con muy bajo impacto, no explota y no es ruidoso
_exploit_ -> Intenta explotar fallos para ganar acceso, muy ruidoso
_brute_ -> Fuerza bruta de credenciales, muy ruidoso
_dos_ -> Pruebas de denegacion de servicio, extremadamente ruidoso
_fuzzer_ -> Envía inputs aleatorios/malformados para buscar crashes. Muy ruidoso.
_discovery_ -> Mapea/descubre hosts y servicios, ruido bajo-medio
_auth_ -> Prueba mecanismos de autenticacion. Ruido medio-alto
_version_ -> Versionado de servicios (-sV)
_broadcast_ -> Envia consultas a la red para descubrir servicios
_external_ -> Busca servicios externos para OSINT. Ruido bajo
_malware_ -> Busca indicadores o comportamientos relacionados con  malware
