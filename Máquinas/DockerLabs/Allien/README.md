_Máquina_: Allien  
_Plataforma_: DockerLabs  
_Sistema operativo_: Linux  
_Dificultad_: Fácil  

Hoy vamos a estar resolviendo la máquina **Allien** de DockerLabs, la cual se basa en el protocolo _Samba_ (SMB) en Linux. Haremos un reconocimiento inicial y descubriremos _shares_ públicos, que nos guiaran hacia la explotación.

**Nuestro Objetivo**: Obtener acceso como root explotando servicios mal configurados.

Esta sera la metodología a efectuar:
- Reconocimiento
- Enumeración de SMB
- Acceso inicial
- Post-explotación
- Escalada de privilegios

**Herramientas a utilizar**:
- nmap
- enum4linux
- smbclient
