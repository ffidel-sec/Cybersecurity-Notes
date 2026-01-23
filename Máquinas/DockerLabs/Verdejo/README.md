_Máquina_: Verdejo  
_Plataforma_: DockerLabs  
_Sistema operativo_: Linux  
_Dificultad_: Fácil 

Hoy vamos a estar resolviendo la máquina **Verdejo** de DockerLabs. A lo largo del laboratorio realizaremos un reconocimiento inicial para identificar los servicios expuestos y detectar distintas **malas configuraciones** que nos permitirán obtener acceso al sistema.

Durante la explotación encontraremos vectores como **Server-Side Template Injection (SSTI)**, manejo inseguro de credenciales y **hashes de contraseñas**, los cuales serán crackeados utilizando **John The Ripper** y **ssh2john**. Finalmente, abusaremos de permisos mal configurados y servicios del sistema para lograr la **escalada de privilegios hasta root**.

**Nuestro Objetivo**: Obtener acceso como usuario privilegiado y escalar hasta **root** explotando vulnerabilidades y configuraciones inseguras del sistema.
Esta será la metodología a efectuar:

- Reconocimiento
- Enumeración de servicios
- Acceso inicial
- Explotación (SSTI)
- Post-explotación
- Cracking de hashes
- Escalada de privilegios

**Herramientas a utilizar**:

- nmap
- curl / navegador web
- john
- ssh2john
- sudo
- herramientas básicas de Linux