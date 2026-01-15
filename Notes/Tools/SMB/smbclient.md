Optimo para interactuar con shares (listar, navegar, descargar/subir archivos). **Es el cliente SMB interactivo**, sirve para una vez que listaste los shares y los
permisos

-s --> Le especifica a smbclient que archivo de config de SMB utilizar
-m --> Fuerza la version de SMB q se va a usar (SMB1/SMB2/SMB3)
El -L sirve para listar los shares y siempre //ip

smbclient -L //192.168.1.101 -N ---> Lista como Anonymous (sin contraseña)
smbclient -L //192.168.1.101 -U usuario%contraseña ---> probar entre '' si no anda
smbclient -U 'usuario%contraseña' -L //192.168.1.101/share --->


Si te lista shares publicos:

smbclient //192.168.1.101/ShareName -N

Con esto entras interactivo y probas ls, get archivo.txt, archivo.pdf, etc etc

una vez con acceso a la consola victima, existen los siguientes comandos:

ls/dir        ---> listar archivos y directorios
put <archivo> ---> subir un archivo
get <archivo> ---> obtener un archivo
mkdir
rmdir
del/rm <archivo> ---> Borra
rename
!<comando> ---> Se usa el ! para correr comandos de tu shell local, por ej:
!whoami ---> ffidel