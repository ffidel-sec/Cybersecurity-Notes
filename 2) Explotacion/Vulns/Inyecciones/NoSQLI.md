#Inyeccion
Si vemos que un formulario se tramita en formato Json o la peticion tiene la cabecera `Content-Type: application/json`, puede llegar a ser una pista de que atras hay NoSQL, como MongoDB (_puerto 27017_)


![[Pasted image 20251112104012.png|150]]

El usuario **NO ES** pedro y la contrasena **NO ES** admin

---
Los primeros payloads que se prueban son los siguientes:

`{"$ne": null}`
`{"$gt": ""}`
`{"$gte": 0}`
`{"$regex": ".*"}`