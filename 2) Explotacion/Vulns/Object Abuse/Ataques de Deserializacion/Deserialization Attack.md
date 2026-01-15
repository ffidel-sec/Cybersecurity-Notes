#javascriptObjectAttack 
Este tipo de ataque se presentan cuando los datos que enviamos son convertidos en objetos y pasan por un proceso de _serializacion_ y _deserializacion_. 

------
### Que significa que un objeto este serializado? 

Basicamente serializar es convertir un objeto en un formato lineal (una sola linea) que la computadora pueda interpretar, guardar o enviar, por ejemplo un Json, XML, SQL, etc. 
Un objeto de **PHP** serializado se veria mas o menos asi:

```
`O:7:"Usuario":2:{s:6:"nombre";s:3:"Ana";s:3:"rol";s:5:"admin";}`
```
Aca basicamente hay un objeto de 7 caracteres, llamado **Usuario**, que posee **2** propiedades: Una _s:tring_ de 6 caracteres, llamada **Nombre**, que posee un valor _s:tring_ de **Ana** y otra propiedad, _s:tring_ llamada **rol** con un valor _s:tring_ de 5 caracteres de **admin**

_s:_ -> string
_O:_ -> Object
_nro:_ -> Cantidad de caracteres

------------
* Una vez sabemos que tenemos un objeto, podemos intentar manipularlo a ciegas, _"Black Box"_ seria el termino, si no tenemos acceso al codigo del backend ni sabemos como se manipulan los datos.
* Se puede buscar en cookies, parametros, Base64 sospechoso, binarios, etc.
* Con eso se puede detectar formatos (PHP, Java, Python, Ruby), intentar modificar propiedades, probar payloads con _gadgets_ (metodos que ejecutan instrucciones dentro del codigo del lenguaje)

Este es un pequeno resumen de este ataque:

- **Decodificás** el objeto encontrado.
    
- **Lo modificás** inyectando _gadgets_ dentro de la estructura serializada (clases, propiedades, métodos mágicos).
    
- **Lo volvés a codificar** en el formato original.
    
- El servidor lo **deserializa** y ejecuta la cadena de gadgets → **RCE / file write / SQL / lo que permita la gadget chain**.
