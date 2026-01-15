---
tags:
  - fuerza-bruta
  - herramienta
  - reconocimiento
  - web
  - url
  - redes
---

```bash
 hydra -s(puerto) -L users.txt -P passwords.txt ssh://192.168.0.12
```

-l  ---> usuario
-L ---> Usuarios.txt
-p ---> password
-P ---> Passwords.txt
ssh ---> Este es el proceso (puede ser cualquiera, pero tiene que seguir si o si con ://IP) 

Asi fuzzeamos un login en una pagina:

```bash
hydra -l admin -P passwords.txt 192.168.0.1 http-<method>-form 'https://google.com/wordpress/wp-login.php:log=^USER^&pwd=^PASS^:S=302'
```

http-post-form o http-get-form ---> depende si el form se manda por get o post, revisar eso antes de fuzzear
/wordpress/wp-login.php: ---> Indica la ruta donde se quiere fuzzear

log   ---> indica el nombre del input type <username> en el html
pwd ---> indica el nombre del input type <password> en el html


EL :S y :F que se indican a continuacion dependen de la respuesta del servidor 

:S ---> S viene de status, si la respuesta es un 302 redirect, entonces es correcto poner S.
:F ---> Se usa cuando la respuesta es texto, por ej, la respuesta da codigo 200 pero dice invalid password.
En dicho caso, seria:
:F=Invalid Password ---> texto sin comillas!

        Si tu cadena contiene un dos-puntos : (que en Hydra separa campos)
        o algún otro carácter que rompa el formato,
        tienes que escapar ese carácter con una barra invertida \. Ejemplo:

        :F=Error\: invalid credentials