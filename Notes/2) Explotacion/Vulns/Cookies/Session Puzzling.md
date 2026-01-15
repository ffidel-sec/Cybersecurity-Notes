Session Puzzling es una vulnerabilidad donde la aplicación reutiliza una sesión previa (generalmente anónima o incluso arbitraria) en vez de generar una nueva cuando un usuario hace login. Esto causa que el servidor “mezcle” estados y termine autenticando una sesión que no corresponde, permitiendo que un session-id controlado antes del login pase a quedar autenticado como otro usuario. El problema no es el usuario, sino el servidor que no rota ni valida correctamente las sesiones.

_Session Puzzling_ = el servidor mezcla sesión anónima + sesión autenticada sin regeneración del session-id.

### Un ejemplo correcto (conceptual)

1. Vos: `PHPSESSID=AAAAAA`
2. Víctima (por alguna razón) también usa `PHPSESSID=AAAAAA`
3. Víctima hace login.
4. El servidor no cambia el session-id → entonces ahora `AAAAAA` está autenticado.
5. Vos seguís teniendo `AAAAAA` → estás dentro.

---
### Por ejemplo...

