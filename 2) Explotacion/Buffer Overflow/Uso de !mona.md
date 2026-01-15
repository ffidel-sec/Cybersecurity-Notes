Crear _bytearray_
```
!mona bytearray -cpb "\x00\x0a"
```
Ese bytearray excluye 0x00 y 0x0a

---
Comparar bytearray con respuesta de la app para encontrar _badchars_
```bash
!mona compare -a 0x022EA128 -f C:\Users\ffidel\Desktop\bytearray.bin 
```

_-a 0x022EA128_ -> Direccion de memoria donde empieza el bytearray 

