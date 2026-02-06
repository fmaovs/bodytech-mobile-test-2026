import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'core/storage_service.dart';
import 'modules/auth/views/login_view.dart';
import 'modules/auth/views/register_view.dart';
import 'modules/home/views/home_view.dart';
import 'modules/auth/controllers/auth_controller.dart';
import 'data/providers/auth_provider.dart' as custom;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await StorageService.init(); 

  Get.put(custom.AuthProvider());
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bodytech Test',
      debugShowCheckedModeBanner: false,

      initialRoute: StorageService.isLoggedIn() ? '/home' : '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/register', page: () => RegisterView()),
        GetPage(name: '/home', page: () => HomeView()),
      ],
    );
  }

  
}