**Cuando nuestro _input_ es mayor al tamano asignado por el desarrollador a dicha variable, y esto no esta contemplado (hay absoluta confianza en el input), podemos sobreescribir registros internos del sistema**

---
Los **BOF** SE DAN EN SU MAYORIA EN _C_/_C++_

---
Formas de averiguar si un binario es de _32 bits_ o _64 bits_:

1) Ejecutando el siguiente comando:
```bash
file nombre_del_binario
```

2) readelf
```bash
readelf -h nombre_del_binario | grep Class
```

3) objdump
```bash
objdump -f nombre_del_binario | grep architecture
```

---

```
               Direcciones de memoria más ALTAS
               ┌───────────────────────────────────┐
               │                                   │
               │  Variables locales                 │
               │  buffers, ints, structs, etc       │
               ├───────────────────────────────────┤
               │  Saved EBP                         │ ← EBP apunta aquí
               │  (base pointer anterior)           │
               ├───────────────────────────────────┤
               │  Saved EIP                         │ ← dirección a la que volverá RET
               │  (return address)                  │
               ├───────────────────────────────────┤
               │  Argumentos de la función          │
               │  (si los hay)                      │
               ├───────────────────────────────────┤
ESP →          │  Top of the stack (TOPE)           │ ← ESP apunta aquí
               │  último valor escrito               │
               └───────────────────────────────────┘
               Direcciones de memoria más BAJAS
```

---

**Buffer** = Espacio de memoria reservado para guardar datos temporales.

_La pila (stack)_ = la zona de **memoria RAM** donde un programa guarda cosas temporales.
Guarda:
- Variables locales
- Direcciones de retorno (EIP/RIP)
- Argumentos de funciones
- Registros salvados
---
**EIP** y **RIP** son los _registros del CPU_ que apuntan a la siguiente instruccion a ejecutar. 

- _EIP_ = Extended Instruction Pointer (arquitectura 32 bits).  
	Registro del CPU que **siempre contiene la dirección de la próxima instrucción**.  
	En un programa vulnerable a buffer overflow, si escribís más datos de los que el buffer soporta, podés llegar a la parte de la pila donde está guardado el **EIP** que se restaurará cuando la función termine.
	Si lo sobreescribís → la CPU salta a donde vos quieras.

- _RIP_ = Instruction Pointer (arquitectura 64 bits).  
    → Diferencias clave:
	- Tiene **64 bits**, pero eso implica direcciones más largas.
	- No podés simplemente poner shellcode en la pila porque suele haber **NX** activado (pila no ejecutable).
	- Casi siempre necesitás **ROP chains**: armar una secuencia de pequeños gadgets para hacer un `execve` o similar.

---
* La **pila** o **stack** = Es la zona de memoria RAM donde un programa guarda cosas temporales (variables, direcciones de retorno como el  _EIP_, entre otros.

* **Buffer** = Espacio de memoria reservado para guardar datos temporales.

* **NOPS** (`0x90`) = Es una instruccion que no hace nada, avanza a la siguiente instruccion. Sirve para hacer un “colchón” donde el CPU puede caer sin crashear. Se usa para que el salto al shellcode sea más flexible.  

* **Padding** = Lo que esta antes del Offset (basura). Se usa para rellenar el _buffer_ hasta llegar al _offset_. 

* **BadChars** = Caracteres que el programa no logra ejecutar, 