# DonationsTracker
**Team 5's Donations Tracker for "Banco de Alimentos Guadalajara"**

**Team Members:**
- Leonardo A01637341
- Roberto A01637335
- Marian A00227534
- Gerardo A01638691
- Ulises A01637321

This is the repository of Team Number 5. In this repository we will be uploading our entire progress on the development of the iOS application for "Banco de 
Alimentos de Guadalajara" using Swift. As of now the name of our project is "Donations Tracker" but this is only a plca holder name, since we haven't decided 
on the name of the application.

## Etapa 3: Desarrollo
En esta etapa creamos este repositorio, puesto que en esta etapa pasamos a ya comenzar el desarrollo de la aplicación. Para este entregable desarrollamos 
las seis principales "Vistas" que va a llevar nuestra aplicación. Las Vistas son las siguientes:
- Log In
- Sign Up
- Home/Metas
- Preferences/Settings
- Mis Donaciones
- ¿Quieres Ayudar?
  - Donativo Económica

Además de las vistas mencionadas seguimos con el desarrollo del documento SRS, en el cual llevamos registro del diseño de la aplicación y otros aspectos
a tomar en cuenta como seguridad y los necesarios diagramas como de clases y de la base de datos.

## Etapa Final: Entrega
Para esta etapa seguimos trabajando sobre los avances y cambios que hicimos para la Etapa pasada. Puesto que lo que teníamos más que nada era la parte del UI
en esta etapa trabajamos más que nada en la funcionalidad de la Aplicación. A continuación se dará una breve explicación de la funcionalidad que se agregó
en cada Vista.

**Log In**
- Si se tiene cuenta creada y se ingresa la contraseña correcta permite entrar a la aplicación usando esa cuenta.
- Al escribir la contraseña esta se oculta (los caracteres se ven como puntos).

**Sign Up**
- Una vez se ingresen los datos de los campos que se requieren y se de click en crear cuenta, su cuenta se registra y se manda a la vista de Log In.
- Se puede leer los Terminos y Condiciones del Banco de Alimentos (se le envía a la página del mismo).

**Home/Metas**
- Si se es admin el botón para crear Metas esta disponible por lo que puede crearlas.
- Si se es admin también se pueden eliminar Metas, haciendo swipe a la izquierda sobre la meta a eliminar.
- Las metas se eliminan de manera automática una vez se llega o se super la meta de cantidad a donar.

**Preferences/Settings**
- Se puede ver los datos vinculados a la cuenta.
- Se puede cambiar la contraseña, se tiene que dar en aceptar para hacer el cambio.
- Se puede Cerra la Sesión, mandando al usuario a la pantalla de Log In.

**Mis Donaciones**
- Se toman los datos de donaciones del usuario y se muestran.
- Se pueden ver los Logros obtenidos y los por desbloquear para ver el requisito para conseguirlos.

**¿Quieres Ayudar?**
- Se puede elegir entre donación Económica que manda a otra vista o en Especie que manda a la página web del Banco de Alimentos.

**Donaciones Económicas**
- Una vez se llenan los campos de los datos requeridos y se de click en aceptar se realiza la donación/pago y se le regresa a la vista anterior.

**Funcionalidad Genral**
- Se tiene una Barra de Navegación con la cual se puede ir a las pantallas principales.
- Se puede ir a la vista de Preferences/Settings desde cualquier pantalla principal.
