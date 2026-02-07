# 🧡 Bodytech Pokédex – Prueba Técnica Flutter

¡Hola! Soy **Mauricio Villanueva** y esta es mi solución al reto técnico de **Desarrollador Flutter para Bodytech**.  
La aplicación fue construida con enfoque en **funcionalidad, rendimiento y una identidad visual alineada a la marca Bodytech (Sangre Naranja)**.

🔗 **Repositorio:**  
https://github.com/fmaovs/bodytech-mobile-test-2026

---

## Requisitos de la Prueba (Entregables)

La solución cumple con los siguientes puntos solicitados:

- **Autenticación con Firebase**  
  Módulo completo de **Login y Registro** de usuarios.
- **Consumo de API**  
  Integración con **PokeAPI** para obtener listado y detalle de Pokémon.
- **Manejo de Estado**  
  Implementación de **GetX** para gestión reactiva y navegación.
- **Persistencia Local / Modo Offline**  
  Uso de **Hive** para funcionamiento sin conexión.
- **Identidad Visual**  
  UI personalizada usando los colores corporativos de Bodytech.

---

## Requisitos del Sistema

Para compilar y ejecutar el proyecto correctamente:

- **Flutter SDK:** `^3.0.0` o superior  
- **Dart SDK:** `^3.0.0` o superior  
- **Plataforma de pruebas:**  
  - Dispositivo físico: *Samsung A54*  
  - Android 14
- **Compatibilidad mínima:** Android 6.0 (API 21)
- **Java:** JDK 11 o JDK 17

---

## Tecnologías y Arquitectura

- **GetX**
  - Separación de lógica y vistas
  - Manejo de estado y navegación
- **Hive**
  - Base de datos NoSQL local
  - Almacenamiento rápido y eficiente
- **Firebase Authentication**
  - Gestión segura de sesiones de usuario

---

## Instrucciones de Ejecución

### Preparación del Entorno

Verifique que Flutter esté correctamente configurado:

```bash
flutter doctor

Clonar el Repositorio
git clone https://github.com/fmaovs/bodytech-mobile-test-2026
cd bodytech-mobile-test-2026


Instalación de Dependencias

El proyecto utiliza Hive para persistencia local. Ejecute:

flutter pub get

Ejecución del Proyecto

Conecte un dispositivo físico o emulador y ejecute:

flutter run

Notas Finales

Modo Offline:
La app guarda automáticamente los Pokémon visualizados.
Si se inicia sin conexión, se carga la última información almacenada en Hive.

Validaciones:
Se implementaron validaciones en tiempo real para:

Formato de correo electrónico

Fortaleza de contraseña

Febrero 2026
Mauricio Villanueva