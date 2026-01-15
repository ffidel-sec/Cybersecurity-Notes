Detectar equipos y listar shares accesibles (util para encontrar ficheros o ubicacion>
Se usa mas que todo para fuzzear usuarios y contraseñas
ES UN TODO EN UNO

--------
_Uso:_

```bash
nxc smb 192.168.0.0/24 -u usuario -p 'ContraRandom' --shares
```

Not1a: si pones -u '' -p '' trata de fijarse sin user ni contra

-------
Usar una contra para muchos usuarios
```bash
nxc smb 192.168.0.0/24 -u /path/usuarios.txt -p password --continue-on-success
```

---------
Usar muchas contraseñas para un usuario
```bash
nxc smb 192.168.0.0/24 -u usuario -p /path/passwords.txt
```

------------
Probar ejecutar comandos desde SSH
```bash
nxc ssh 192.168.1.110 -u '' -p '' -x whoami
```
