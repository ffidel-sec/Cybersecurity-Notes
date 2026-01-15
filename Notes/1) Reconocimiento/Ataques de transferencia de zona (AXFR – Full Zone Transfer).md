Este ataque iria mas bien en la **fase de reconocimiento**, ya que es algo muy simple, que en realidad no explota ninguna vulnerabilidad ni modifica nada. Es tan basico como escanear puertos o buscar subdominios.

------
Con el siguiente comando, enumeramos los servidores NS (Name Servers) 

```bash
dig NS nasa.gov
```

```bash
;; ANSWER SECTION:
nasa.gov.		600	IN	NS	a12-64.akam.net.
nasa.gov.		600	IN	NS	a5-66.akam.net.
nasa.gov.		600	IN	NS	a8-66.akam.net.
nasa.gov.		600	IN	NS	a1-32.akam.net.
nasa.gov.		600	IN	NS	a14-67.akam.net.
nasa.gov.		600	IN	NS	a9-64.akam.net.
```

--------
Luego buscamos por el AXFR a cada nombre de dominio especifico

```bash
dig AXFR nasa.gov @a12-64.akam.net. 
dig AXFR nasa.gov @a5-66.akam.net.
...
...
```

---------
