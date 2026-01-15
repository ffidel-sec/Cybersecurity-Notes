Cuando realizamos un escaneo y vemos que tiene un puerto (por lo general -> 3128, 8080 o 8000) abierto con _squid_ corriendo atras, significa que atras hay un proxy que intercepta las peticiones.

Si intentamos hacer un curl:

```bash
curl http://192.168.0.0:80
```

Probablemente no te vaya a resolver, ya que habria que hacerle un curl al puerto 3128 (o el q sea). Pero si utilizamos este mismo _squid proxy_ como _proxy_, y esta mal configurado, me permitiria enumerar todos los puertos con los siguientes comandos:

```bash
curl http://192.168.0.0 --proxy 192.168.0.0:3128
```

Es decir, el proxy **SI me permite** ver el puerto 80! pero no deberia permitirme ver el resto de puertos, si me deja --> _bypass de SQUID Proxy_. Basicamente se utiliza el squid proxy como proxy propio.

------
La misma flag --proxy puede servir para **gobuster** y creo que --proxies en **nmap**
 
---
Si no se entiende mandale el 2do comando a chatgpt y fijate.
