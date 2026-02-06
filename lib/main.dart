import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

// Importaciones de tus archivos
import 'firebase_options.dart';
import 'core/storage_service.dart';
import 'modules/auth/views/login_view.dart';
import 'modules/auth/views/register_view.dart';
import 'modules/home/views/home_view.dart';
import 'modules/auth/controllers/auth_controller.dart';
import 'data/providers/auth_provider.dart' as custom;

void main() async {
  // Garantiza que los servicios nativos estén listos
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicialización de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Inicialización de Hive
  await StorageService.init(); 

  // Inyección de dependencias (Dependency Injection)
  Get.put(custom.AuthProvider());
  Get.put(AuthController());

  runApp(const MyApp());
}

// Esta es la clase que te faltaba o que tenía el error
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bodytech Test',
      debugShowCheckedModeBanner: false,
      // Lógica de persistencia de sesión
      initialRoute: StorageService.isLoggedIn() ? '/home' : '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/register', page: () => RegisterView()),
        GetPage(name: '/home', page: () => HomeView()),
        // La ruta /register la comentamos o la creamos en el siguiente paso
        // GetPage(name: '/register', page: () => const RegisterView()), 
      ],
    );
  }
}