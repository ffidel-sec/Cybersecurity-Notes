---
tags:
  - fuerza-bruta
  - herramienta
  - fuzzing
  - reconocimiento
  - url
  - web
---

Optimo para casos mas complejos (formularios, auth, multiples payloads, etc)

```bash
wfuzz -c -w wordlist.txt -u https://FUZZ.escuelaspiasdeargentina.com --hc 404 -t 30
```

-c         --> color
--hc=   --> Oculta por codigo de estado
--sc=   --> Muestra solo dichos codigos
--hl=   --> Oculta respuestas por cantidad de lineas
--hw= --> Oculta por cantidad de palabras
-L -> Follow Redirect

--sc= --> show code, filtra por codigo de estado 
--sl= -> show line, filtrar por numero de lineas
-z file,wordlist.txt -> Archivos de tipo diccionario 

Fuzzear parametros con numeros o IDs: 

```bash
wfuzz -z range,1-20000 -u https://mercadolibre.com/search?product_id=FUZZ
```

-z range,1-20000 --> Cambia la palabra FUZZ por cada nro del 1 al 20000, ideal para parametros que se basen en numeros para dar resultados

------
Para hacer un ataque de BF a un campo username o password:

```bash
wfuzz -w wordlist.txt -d 'username=FUZZ&password=password' https://url.com
```