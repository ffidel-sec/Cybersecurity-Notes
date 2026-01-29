_Máquina_: **Apolos**  
_Plataforma_: **DockerLabs**  
_Sistema operativo_: **Linux**  
_Dificultad_: **Media**

Hoy vamos a estar resolviendo la máquina **Apolos** de DockerLabs, la cual presenta una aplicación web vulnerable a **inyección SQL** y **abuso de subida de archivos**. A través de estas vulnerabilidades obtendremos acceso inicial al sistema y posteriormente realizaremos una **escalada de privilegios mediante crackeo de credenciales locales**.

**Nuestro Objetivo**: Obtener acceso como **root** explotando malas configuraciones y debilidades en la gestión de credenciales.

Esta será la metodología a efectuar:

- Reconocimiento
- Enumeración web
- Inyección SQL
- Abuso de subida de archivos
- Acceso inicial al sistema
- Post-explotación
- Escalada de privilegios mediante crackeo de hashes y `su`

**Herramientas a utilizar**:
- nmap
- john
- herramientas de fuerza bruta/crackeo
- utilidades básicas de Linux