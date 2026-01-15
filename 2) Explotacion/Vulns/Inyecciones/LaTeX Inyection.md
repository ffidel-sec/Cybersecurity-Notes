**LaTeX = un lenguaje + compilador**  
Vos escribís **texto + comandos** y LaTeX lo **compila** para generar un **PDF con formato profesional**. 

_LaTeX_ ejecuta comandos!!! Aca aparece la vuln.
Estos son algunos recursos interesantes:
https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/LaTeX%20Injection --> Aca hay una lista de payloads para probar si es vulnerable
https://0day.work/hacking-with-latex/
----------
Una forma de burlar al sistema si cierto codigo o cierta palabra esta en una blacklist, es por ejemplo con el siguiente comando:

```
\def\first{pep}
\def\second{ito}
\first\second
```
