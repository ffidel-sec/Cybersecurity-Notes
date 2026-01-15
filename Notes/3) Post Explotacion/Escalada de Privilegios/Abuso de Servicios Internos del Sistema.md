Con el siguiente comando podemos listar los _servicios internos_ **CON TIMER** que estan corriendo:
```bash
systemctl list-timers
```

Con este comando podemos listar todos los servicios **ACTIVOS** en ese momento:
```bash
systemctl list-units --type=service --state=running
```

Todos los servicios cargados (running + stopped):
```bash
`systemctl list-units --type=service`
```

Servicios habilitados al arranque (enabled):
```bash
systemctl list-unit-files --type=service --state=enabled
```

Servicios deshabilitados:
```bash
systemctl list-unit-files --type=service --state=disabled
```

