#Inyeccion

El ataque de **truncado SQL**, también conocido como **SQL Truncation**, es una técnica de ataque en la que un atacante intenta **truncar** o **cortar** una consulta SQL para realizar acciones maliciosas en una **base de datos**. Es una vulnerabilidad **si o si** basada en el tamaño de la consulta, **por ejemplo**:

Yo tengo el usuario `fidel@gmail.com` -> _15 caracteres_.

Si la consulta tiene un varchar 20 ponele, yo puedo hacer la siguiente peticion:

username: `fidel@gmail.com     adsas` 
password: `idk123` 

Le cambio la contra a `fidel@gmail.com`.-

---
Intentar esta inyeccion SI:
_1ro_ -> Te deja meter espacios en el input
_2do_ -> El formulario permite enviar valores larguísimos sin limitar caracteres o sin cortar en frontend:

* Inserto: `victimaaaaaaaaa`
- Intento loguear con: `victima`  
    → Si funciona: vulnerable.
    
_3ro_ -> Se puede agregar espacios, tabs u otros rellenos sin ser filtrados.    
_4to_ -> La app hace comparaciones lógicas antes de insertar (ej: “email no existe”) pero la DB almacena algo distinto por truncado.
_5to_ -> Cuentas duplicadas / colisiones raras al registrar datos parecidos—señal clara de truncamiento silencioso.
