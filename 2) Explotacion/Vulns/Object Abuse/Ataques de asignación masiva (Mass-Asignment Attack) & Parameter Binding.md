#javascriptObjectAttack
Este tipo de ataques se basan en dejar que el usuario envie propiedades que no deberian poderse modificar, y el backend las interpreta sin validarlas.

--------
## De donde proviene el nombre?
### ✔ Mass Assignment
Nombre clásico en seguridad.  
Viene del término usado en frameworks como Rails: _asignación masiva de atributos a un modelo_.

### ✔ Parameter Binding
Nombre más técnico / genérico.  
Describe el proceso donde el framework hace “bind” automático entre **parámetros entrantes** → **propiedades del objeto**.

#### Los 2 son lo mismo pero depende de quien lo explique 

-----
Supongamos que tenemos el siguiente formulario, con las siguientes respuestas:

![Screenshot](../../../../Images/mass_assignment_attack1.png)

Pero... y si le agrego la propiedad _role_ a mi peticion?

![Screenshot](../../../../Images/mass_assignment_attack2.png)

