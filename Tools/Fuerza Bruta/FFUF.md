---
tags:
  - herramienta
  - fuerza-bruta
  - url
  - reconocimiento
  - web
  - fuzzing
---

Herramienta ideal para enumeracion de directorios/subdominios utilizando fuzzing

```bash
ffuf -c -w wordlist -u https://escuelaspiasdeargentina.com/FUZZ.php
```

 -c --> color
-mc --> Mostrar solo dichos codigos
-fc --> Oculta por codigo de estado
-fs --> Oculta respuestas por content-length
-fl --> Oculta respuestas por cantidad de lineas
-fw --> Oculta por cantidad de palabras
-recursion -recursion-depth 2 --> Para que sea recursivo 1 directorio



```bash
seq 1 20000 > nums.txt

 ffuf  -w nums.txt -u https://url.com/FUZZ -t 40 
```

Con esto podemos atacar a parametros que definan elementos con IDs por ejemplo, haciendo una wordlist con nros del 1 al 20000, no viene con la funcion como wfuzz