```bash
searchsploit WordPress 2.2
```

Devuelve algo asi:
```bash
------------------------------------------------------------------------------------------------------------------------- ---------------------------------
 Exploit Title                                                                                                           |  Path
------------------------------------------------------------------------------------------------------------------------- ---------------------------------
NEX-Forms WordPress plugin < 7.9.7 - Authenticated SQLi                                                                  | php/webapps/51042.txt
Translatepress Multilinugal WordPress plugin < 2.3.3 - Authenticated SQL Injection                                       | php/webapps/51043.txt
WordPress Core 1.2.1/1.2.2 - '/wp-admin/post.php?content' Cross-Site Scripting                                           | php/webapps/24988.txt
WordPress Core 1.2.1/1.2.2 - '/wp-admin/templates.php?file' Cross-Site Scripting                                         | php/webapps/24989.txt
WordPress Core 1.2.1/1.2.2 - 'link-add.php' Multiple Cross-Site Scripting Vulnerabilities                                | php/webapps/24990.txt
```

Con el siguiente comando analizamos el contenido del _exploit_:
```bash
searchsploit -x php/webapps/51042.txt
```

Con el siguiente traemos el _exploit_ al directorio actual
```bash
searchsploit -m php/webapps/51042.txt
```
