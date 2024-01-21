# 📲 Dragon Ball Heroes Guide App - Práctica Módulo Fundamentos de iOS

Esta aplicación, creada en Xcode con Swift, te sumerge en un viaje interactivo para descubrir a los personajes de Dragon Ball y sus increíbles transformaciones. Esta es la práctica del Módulo Fundamentos de Desarrollo iOS en el bootcamp de Desarrollo de Apps Móviles de KeepCoding.

## Características Principales

- **Inicio de Sesión:** Al abrir la aplicación, los usuarios son recibidos con una página de inicio de sesión para acceder a la aplicación.

  <table>
  <tr>
    <td><img src="https://github.com/Boncroix/DragonBallGuide/blob/main/Images/LaunchScreen.png" width="200" /></td>
    <td><img src="https://github.com/Boncroix/DragonBallGuide/blob/main/Images/LoginViewController.png" width="200" /></td>
    <td><img src="https://github.com/Boncroix/DragonBallGuide/blob/main/Images/LoginFailedViewController.png" width="200" /></td>
  </tr>
  </table>

  - **Registro en la API DragonBall:** Antes de utilizar la funcionalidad de inicio de sesión, los usuarios deben registrarse en la API DragonBall de KeepCoding para obtener credenciales válidas. En   caso de no estar registrados, pueden utilizar las siguientes credenciales de ejemplo:
    - Email: boncroix@gmail.com
    - Contraseña: 12345678

- **Catálogo de Héroes:** Una vez autenticados, los usuarios son llevados a un catálogo que presenta a los héroes más destacados de la serie de manga Dragon Ball.

- **Detalles del Héroe:** Al hacer clic en un héroe específico, se despliega una pantalla con una descripción detallada del personaje y un botón para explorar sus transformaciones.

- **Exploración de Transformaciones:** Al pulsar sobre el botón de transformaciones, los usuarios acceden a un listado que exhibe las diversas metamorfosis del héroe seleccionado.

- **Descripciones e Imágenes de Transformaciones:** Cada transformación viene acompañada de su respectiva descripción y una imagen.

  <table>
  <tr>
    <td><img src="https://github.com/Boncroix/DragonBallGuide/blob/main/Images/HeroesCollectionViewController.png" width="200" /></td>
    <td><img src="https://github.com/Boncroix/DragonBallGuide/blob/main/Images/DetailViewController.png" width="200" /></td>
    <td><img src="https://github.com/Boncroix/DragonBallGuide/blob/main/Images/TransformationsTableViewController.png" width="200" /></td>
    <td><img src="https://github.com/Boncroix/DragonBallGuide/blob/main/Images/DetailTransformationsViewController.png" width="200" /></td>
  </tr>
  </table>

## Modelo MVC

La aplicación sigue el patrón de diseño Modelo-Vista-Controlador (MVC), donde:

- **Modelo:** Los datos de los héroes y sus transformaciones se consumen de la API DragonBall de KeepCoding.

- **Vista:** La interfaz de usuario y la presentación de la información.

- **Controlador:** Gestiona la lógica de la aplicación y actúa como intermediario entre el modelo y la vista.

## Requisitos de Desarrollo

- Xcode
- Swift

## Instrucciones de Uso

1. Clona el repositorio.
2. Abre el proyecto en Xcode.
3. Ejecuta la aplicación en el simulador o dispositivo iOS.

## Contribuciones

¡Contribuciones son bienvenidas! Si deseas mejorar la aplicación, abre un *pull request* y estaré encantado de revisarlo.
