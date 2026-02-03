import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importante
import 'package:get/get.dart';
import 'firebase_options.dart'; // Este es el archivo que acabas de generar
import 'core/storage_service.dart';
import 'modules/auth/views/login_view.dart';
import 'modules/auth/controllers/auth_controller.dart';
import 'data/providers/auth_provider.dart' as custom;

void main() async {
  // 1. Asegurar que los bindings de Flutter estén listos
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Inicializar Firebase con las opciones generadas
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // 3. Inicializar Hive (Persistencia local)
  await StorageService.init(); 

  // 4. Inyectar dependencias (GetX)
  Get.put(custom.AuthProvider());
  Get.put(AuthController());

  runApp(const MyApp());
}