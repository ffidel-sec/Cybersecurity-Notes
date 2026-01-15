---
tags:
  - fuerza-bruta
  - herramienta
  - reconocimiento
  - url
  - web
---

```bash
gobuster dir -u <url> -w wordlist.txt --> Para directorios
gobuster vhost -u <url> -w worlist.txt --> Para subdirectorios
```

--exclude-length --> Excluye un tamaño
-b 302 -->  Para excluir un codigo de estado
-s 200,301 --> Para ver solo los 200 y 301

**-x php,html,txt,bak,tar,php.bak,** --> Para que haga BF a las extensiones de los archivos si dan 200

dir        --> Le dice a Gobuster que se quieren enlistar directorios
vhosts --> Le dice a Gobuster que se quieren enlistar subdominios
