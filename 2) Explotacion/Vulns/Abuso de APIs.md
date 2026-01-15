#Inyeccion #API 
Una _API (Application Programming Interface)_ es un conjunto de reglas y funciones que un software expone para que otro pueda pedirle datos o hacer acciones, permite a diferentes aplicaciones **comunicarse entre si**. Funciona como un intermediario que define como dos programas deben interactuar. Puede ser entre 2 sistemas distintos o en el mismo sistema, comunicando al front-end con back-end.

------
_1ro_ --> Identificar y enumerar APIs de la web:
* Carga recursos JSON 
* Request XHR/fetch en la pestana Netword 
* Ruta típica (pero no obligatorio): `/api/`, `/v1/`, `/auth/`, `/users/`.
* Headers con -> `Content-Type: application/json` -> API 99% de las veces.
* Identificar con EndPointer 
* intentar fuzzear directorios con la wordlist `api-endpoints-res.txt`. Tambien probar poniendole la flag -x json,js

_2do_ --> Crear una coleccion en _Postman_ y registrarlas ahi, para tener un orden y registro q este piola.
En _postman_ se pueden crear variables con tokens o cookies, acordate de eso, _para poder acceder a los recursos quizas hay q tener un token de inicio de sesion_, el cual suele estar en el recurso q esta cargando la API -> 

![Screenshot](../../../Images/api_abuse2.png)

_3ro_ --> Una vez identificadas APIs, como viajan y que solicitudes hacen, es factible empezar a probar inyecciones.  
