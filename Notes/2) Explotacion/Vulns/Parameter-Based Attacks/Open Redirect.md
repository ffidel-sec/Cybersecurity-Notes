Se dice que encontramos esta vulnerabilidad cuando tenemos la capacidad de controlar un parametro a la hora de hacer una redireccion:

Supongamos que tenemos la siguiente url:

```
https://google.com?redirect=https://google.es
```

Si no esta sanitizado el parametro _redirect_, podemos modificarlo de la siguiente forma:

```
https://google.com?redirect=https://evil.com --> Deberia hacer redireccion
```

---------
Si hay algun firewall se puede bypassear urlencodeando caracteres de la url a redireccionar y volviendo a urlencodear el %, hay q ir probando:

```
https://google.com?redirect=https://evil%252ecom
```

_%2e_ -> Urlencode del **.**
_%25_ -> Urlencode del **%**
