# Bodytech Pokedex - Prueba Técnica

¡Hola! Soy Mauricio Villanueva y esta es mi solución al reto técnico de Desarrollador Flutter para Bodytech. El objetivo fue crear una aplicación funcional, ágil y con una identidad visual alineada a la marca.

## 🚀 Lo que usé para este proyecto

Traté de mantener las cosas simples pero potentes, usando herramientas que permiten que la app se mueva rápido:

* **Flutter & Dart:** Para el desarrollo multiplataforma.
* **GetX:** Lo usé para manejar el estado de la app y la navegación. Me gusta porque permite separar la lógica de la vista de forma muy limpia.
* **Hive:** Esta fue mi elección para el modo offline. Si ya cargaste los Pokémon, puedes verlos sin internet porque se guardan en una base de datos local ligera.
* **Firebase Auth:** Para que el registro e inicio de sesión sean reales y seguros.
* **PokeAPI:** De donde traigo toda la información de los Pokémon en tiempo real.

## 🏗️ Cómo organicé el código

Dividí el proyecto en carpetas para que sea fácil de entender y escalar:

1.  **Data:** Aquí están los modelos y lo que conecta con la API y Hive.
2.  **Modules:** Separé la parte de Autenticación (Login/Registro) de la parte de la Pokedex (Home/Detalles).
3.  **UI/UX:** Usé los colores "Sangre Naranja" (Naranja, Negro y Gris) para que la app se sienta parte del ecosistema Bodytech.

## 🛠️ Cómo correr la app

1. Clonar el repositorio:
   `git clone https://github.com/fmaovs/bodytech-mobile-test-2026`
2. Instalar paquetes:
   `flutter pub get`
3. Asegurarse de tener el archivo `google-services.json` en `android/app/`.
4. Ejecutar:
   `flutter run`

## 📝 Notas del desarrollador
* Implementé el uso de **Hero animations** para que al tocar un Pokémon, la imagen "vuele" a la siguiente pantalla, dándole un toque más premium.
* La app tiene validaciones de formularios para evitar errores al registrarse.
* Me enfoqué en que la arquitectura fuera lo suficientemente robusta para ser el inicio de una app más grande.

---
Mauricio Villanueva - 2026