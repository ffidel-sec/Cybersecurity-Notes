1¿Que es _iptables_?
Es una herramienta de linux para configurar el firewall del kernel, que controla que trafico entra, sale o pasa por el sistema. Se utiliza mas para actuar de manera inmediata por si se esta sufriendo un ataque o circunstacias repentinas, ya que al reiniciar el sistema las reglas se eliminan. Pero se puede revertir la situacion con el siguiente comando:

```bash
sudo iptables-save > ~/rules.v4
```

Y podemos restaurarlas con el siguiente:
```bash
sudo iptables-restore < -/rules.v4
```

El _~/rules.v4_ es como un **backup** de las reglas, puede tener cualquier nombre

En _Debian_/_Ubuntu_, podemos instalar _iptables-persistent_ y se trabaja asi:

![Screenshot](../../Images/iptables_image4.png)
 
---------------
¿Cual es su _funcion_?
Su funcion es permitir, bloquear o redirigir paquetes segun ciertas reglas establecidas.

¿Como se utiliza?
_iptables_ esta compuesta por tablas y cadenas. 


![Screenshot](../../Images/iptables_image3.png)

Aqui se ven representadas las 3 cadenas (_INPUT_, _OUTPUT_ y _FORWARD_), cada una representa el **recorrido** del paquete.

_INPUT_ -> Trafico que _entra_ al host, paquetes dirigidos a la misma maquina.
_OUTPUT_ -> Trafico que _sale_ del host, paquetes que la maquina envia.
_FORWARD_ ->Trafico que _pasa a traves_ del host, si es que hace de router/firewall



![Screenshot](../../Images/iptables_image.png)


Las tablas mas conocidas son:
_filter_ -> Permitir o bloquear paquetes (firewall normal)
_nat_ -> Cambiar direcciones ip o puertos
_mangle_ -> Modificar detalles del paquete
_raw_ -> Excluir del seguimiento de conexiones 

En general, se usa la tabla _filter_ para el firewall comun.

----------
Estos son los comandos mas utilizados para configurar firewall

```bash
iptables -L -n -v 
```

Ese comando lista las reglas actuales


```bash
iptables -F || iptables --flush
```

_-F_ o _--flush_ -> Borra o limpia todas las reglas actuales


```bash
iptables -P <CHAIN> <POLICY>
```

_-P_ -> Definir politica por defecto (_ACCEPT_/_DROP_) 


```bash
sudo iptables -A INPUT -i eth0 -p tcp --dport 22 -j ACCEPT
```

_-A_-> Append, agrega una regla al final de la cadena _INPUT_ que controla el trafico entrante al sistema (puede ser _Input_/_Output_/_Forward_).
_-p_ -> Indica el protocolo (_TCP_/_UDP_/_ICMP_/_all_)
_-i_ -> Especificamos una interfaz de red.
_--dport_ -> **Puerto Destino**: Indica el puerto al que va dirigido la regla. Si no se especifica escucha en todos los puertos
_--sport_ -> **Puerto de Salida**: Indica el puerto de salida del equipo local, se usa mas en _Forward_ o _Output_
_-j_ -> "_jump_", indica la respuesta que se va a dar si se da la condicion. Pueden ser las siguientes:
*	**ACCEPT** -> Deja pasar el paquete 
*   **DROP** -> Lo descarta sin responder, mas sigiloso
*	**REJECT** -> Lo bloquea pero responde con un error 
*	**LOG** -> Solo lo registra, no afecta el flujo
Esos son los mas comunes, pero hay mas.

_-m conntrack_-> _-m_ carga modulos, _conntrack_ ---> Acepta paquetes de los equipos que estan conectados al momento de crear la regla
_--ctstate_ -> Condiciona a que equipos se le aplica la regla:

```bash
sudo iptables -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
```

- `NEW`: paquete que inicia una nueva conexión.
- `ESTABLISHED`: conexión ya existente.
- `RELATED`: conexión nueva pero relacionada (por ejemplo, conexión FTP de datos).
- `INVALID`: paquete que no encaja en ningún estado válido.

-------------
------------ 
----------
### Importante

Para configurar correctamente el firewall, hay que saber que las reglas se van ordenando por el orden en que las creamos, **EL ORDEN ES MUY IMPORTANTE**, y se va filtrando el trafico a medida que entra. Con el siguiente comando especificamos la _posicion_ en la que queremos que es aplique la regla, en este caso, _5_:

```bash
sudo iptables -I INPUT 5 -j ACCEPT
```


al ultimo, **SIEMPRE**, se debe poner este comando, ya que si el cliente que esta haciendo la peticion, no cumplio con ninguna regla, deberia ser rechazado:

```bash
sudo iptables -A INPUT -j DROP
```

Esto rechaza todo lo que paso todas las reglas, es decir, si no entro antes a ninguna regla, en la ultima se debe rechazar, **AVERIGUAR ESTO BIEN** antes de configurar un firewall.

---------------
--------
-------------

```bash
sudo iptables -D INPUT 3
```

Este comando indica que se quiere _eliminar_ la regla numero _3_ de _INPUT_.

--------

```bash
sudo iptables -A INPUT -s 192.168.0.123 -j DROP
```

Este comando **interactua** con IPs (tambien pueden ser _MACs_), pueden ser _publicas_ o _privadas_. Se pueden bloquear o aceptar todo o lo que se _quiera_. Tambien se le pueden adjuntar _servicios_ o _puertos_ 

