Las _capabilities_ son permisos finos del kernel que permiten al usuario realizar acciones privilegiadas sin necesitar el bit SUID (root). Se diferencian de los [[Binarios]] SUID ya que **no es todo o nada**, porque brindan permisos parciales. Por ejemplo, `cap_net_bind_service` permite abrir puertos <1024 (por debajo del 1024); `cap_net_raw` permite crear raw sockets; `cap_sys_admin` es casi root-level y muy potente.

-------------
Se pueden buscar con el siguiente comando:

```bash
getcap -r / 2>/dev/null
```


