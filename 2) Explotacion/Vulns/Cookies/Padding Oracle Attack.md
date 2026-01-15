Esta vulnerabilidad se da cuando el metodo de cifrado de la cookie es **en bloques** y tiene un padding o relleno, es decir:

_Fidel123_ -> 8 bytes (8 caracteres) ----------- _AES_ -> 16 bytes (pero se puede expandir) 

"_Fidel123_/%08/%08/%08/%08/%08/%08/%08/%08" ---> (%08 por los 8 caracteres faltantes en los 16 bytes de _AES_)


-------
_Cipher Block Chaining (CBC)_ ---> Modo de cifrado, el **CBC** es en bloques. Dentro del mismo, hay varios "motores" de cifrado:


🔹 AES (Advanced Encryption Standard) —> 128-bit block, 16 bytes (**el más usado hoy**).

🔹 DES (Data Encryption Standard) —> 64-bit block (obsoleto).
🔹 3DES (Triple DES) —> 64-bit block (lento, obsoleto).
🔹 Twofish — 128-bit block.  
🔹 Camellia — 128-bit block.  
🔹 CAST5 / CAST128 — 64-bit block.  
🔹 IDEA — 64-bit block.  
🔹 Serpent — 128-bit block.  
🔹 RC5 / RC6 — 64-bit o 128-bit (dependiendo de configuración).

----------
### Forma de Desencriptar y Encriptar 

Con el herramienta _PadBuster_, podemos insertar una cookie de sesion o cualquier token e intentar desencriptarlo.

```bash
padbuster <url> <valor encodeado> <tamano en bytes> 
```

Ademas, despues se le pueden poner mas opciones, por ejemplo:
_-cookie_ --> Nombre de la cookie y valor
y supongamos que pudo desencriptar la cookie y es asi: `user=Fidel123`

```bash
padbuster cooperadores.com.ar/login/index.php cdqr044ms59hed3i4t8fmv06bf 16 -cookie "MoodleSession=cdqr044ms59hed3i4t8fmv06bf" -plaintext 'user=admin'
```

Eso te da la cookie y vos probas si podes insertarla.

------
## **Cómo detectar un Padding Oracle (paso a paso)**

1. **Identificá un parámetro cifrado**
    
    - Largo muy grande (16, 32, 48 bytes… múltiplos de 16).
        
    - Caracteres típicos de base64 (`=`, `+`, `/`).
        
    - Cambia completamente al modificar un byte.
        
2. **Modificá 1 byte del ciphertext**
    
    - Cambiá un byte al azar (por ejemplo, en Burp Decoder → Hex).
        
    - Enviá la request.
        
3. **Observá la respuesta**
    
	- Si el servidor responde **diferente** dependiendo del byte modificado, hay posibilidad de oracle.
        
    
    Ejemplos típicos:
    
    - 500 → “padding incorrecto”
        
    - 400 → “MAC inválida”
        
    - 200 → request aceptada
        
    - 403 → “token inválido”
        
4. **Patrón claro**
    
    - **Errores distintos según el padding** = CANDIDATO a oracle.
        
    - **Siempre el mismo error** = **NO oracle**.
        
5. **Comprobación final**
    
    - Probá varios bytes.
        
    - Si el servidor sigue respondiendo _consistentemente distinto_ según el valor → **es vulnerable**.