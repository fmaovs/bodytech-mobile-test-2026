# Bodytech Pokedex - Prueba Técnica

¡Hola! Soy Mauricio Villanueva y esta es mi solución al reto técnico de Desarrollador Flutter para Bodytech. He construido esta aplicación enfocándome en crear un producto funcional, ágil y con una identidad visual alineada a la marca ("Sangre Naranja").

**Link del repositorio:** [https://github.com/fmaovs/bodytech-mobile-test-2026](https://github.com/fmaovs/bodytech-mobile-test-2026)

## ✅ Requisitos de la Prueba (Entregables)

He cumplido con los siguientes puntos clave solicitados:

* **Autenticación con Firebase:** Módulo completo de Login y Registro de usuarios.
* **Consumo de API:** Integración con PokeAPI para obtener listado y detalles.
* **Manejo de Estado:** Uso de **GetX** para una gestión reactiva.
* **Persistencia Local (Modo Offline):** Implementación de **Hive** para que la app funcione sin conexión.
* **Identidad Visual:** Interfaz personalizada con los colores corporativos de Bodytech.

## ⚙️ Requisitos del Sistema para Compilación

Para garantizar el correcto funcionamiento del proyecto, se recomienda el siguiente entorno:

* **Flutter SDK:** ^3.0.0 o superior.
* **Plataforma de pruebas:** Probado en dispositivo físico Samsung A54 (Android 14).
* **Compatibilidad mínima:** Android 6.0 (API 21).
* **Java:** JDK 11 o 17.

## 🚀 Tecnologías y Arquitectura

Elegí estas herramientas para asegurar un rendimiento fluido:

* **GetX:** Para separar la lógica de negocio de las vistas y manejar la navegación.
* **Hive:** Una base de datos NoSQL ultra rápida para el almacenamiento local.
* **Firebase Auth:** Para la gestión segura de sesiones de usuario.

**Estructura del Proyecto:**
* `data/`: Modelos de datos y proveedores (API/Hive).
* `modules/`: Capas de lógica y vista divididas por funcionalidad (Auth y Home).
* `core/`: Servicios globales como el almacenamiento persistente.

## 🛠️ Cómo ejecutar el proyecto

1. **Clonar el repositorio:**
   ```bash
   git clone [https://github.com/fmaovs/bodytech-mobile-test-2026](https://github.com/fmaovs/bodytech-mobile-test-2026)