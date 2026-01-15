---
tags:
  - cms
  - reconocimiento
  - web
---

Esta herramienta sirve para escanear y reconocer paginas elaboradas con WordPress.

```bash
wpscan --update ---> Para actualizar la base de datos 
wpscan --url https://idk.com/wordpress 
wpscan --url https://idk.com/wordpress -e u,ap,at --api-token="tu_api_token_de_wpscan.com" 
```
 
 -e --> <enumerate> 
 
**Luego le decis que queres enumerar:**

u  -> Usuarios
vp -> vulnerable plugins
ap -> all plugins
p  -> popular plugins
cb -> config backups
vt -> vulnerable themes
at -> all themes
dbe -> db exports 