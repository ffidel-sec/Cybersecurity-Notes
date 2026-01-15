https://deephacking.tech/pivoting-con-netsh/
---
_Netsh_ cumple la funcion de **socat** pero en windows, el uso es el siguiente:

```cmd 
netsh interface portproxy add v4tov4 listenport=<puerto a escuchar> listenaddress=<direccion a escuchar> connectport=<puerto a conectar> connectaddress=<direccion a conectar>
```
