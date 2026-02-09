_Máquina_: **Veneno**  
_Plataforma_: **DockerLabs**  
_Sistema operativo_: **Linux**  
_Dificultad_: **Media**

Hoy vamos a estar resolviendo la máquina **Veneno** de DockerLabs, la cual presenta una aplicación web vulnerable a **Local File Inclusion (LFI)**. A través de la explotación de esta vulnerabilidad utilizando **wrappers de PHP** y la herramienta **php_filter_chain_generator**, lograremos obtener ejecución remota de código y acceso al sistema.

Posteriormente realizaremos enumeración local para identificar posibles vectores de escalada y finalmente obtendremos acceso como **root**.

**Nuestro Objetivo**: Obtener acceso como **root** explotando un LFI mediante wrappers y abusando de configuraciones inseguras del sistema.

---

## Metodología

- Reconocimiento
- Enumeración web
- Identificación de LFI
- Explotación del LFI mediante wrappers
- Generación de payload con `php_filter_chain_generator`
- Obtención de acceso inicial
- Post-explotación
- Escalada de privilegios

---
## Herramientas utilizadas

- nmap
- exiftool
- php_filter_chain_generator
- curl
- utilidades básicas de Linux