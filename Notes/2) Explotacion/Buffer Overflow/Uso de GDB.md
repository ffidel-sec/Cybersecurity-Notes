_GNU Debugger_ es un depurador de código que permite inspeccionar el funcionamiento interno de programas

```bash
gdb <binario>
```

una vez entramos en la consola interactiva podemos hacer los siguientes comandos:

_r_ -> Run, corre el binario. Si este necesita una entrada, se hace aca:

```bash
gef➤ r -sCV
```
---
Crea una cadena de 50 bytes.
```bash
gef➤ pattern create 50
```

Vos le pasas esa cadena:
```bash

```

```bash
gef➤ pattern offset $eip
```

---
_checksec_ muestra que protecciones de seguridad tiene el binario
```
gef➤ checksec
```

- **Canary** → protege el stack
- **NX** → stack no ejecutable
- **PIE** → direcciones aleatorias (ASLR)
- **RELRO** → protege GOT
- **Fortify** → funciones seguras

---