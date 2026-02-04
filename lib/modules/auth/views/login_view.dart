import 'package:bodytech_test/modules/auth/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  // Buscamos el controlador que ya inyectamos en el main.dart
  final AuthController authController = Get.find<AuthController>();
  
  // Llave para validar el formulario
  final _formKey = GlobalKey<FormState>();
  
  // Controladores de texto para capturar lo que el usuario escribe
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bodytech App - Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Bienvenido", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              
              // Campo de Email con validación GetX
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Correo Electrónico", border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) return "El correo es obligatorio";
                  if (!GetUtils.isEmail(value)) return "Ingresa un correo válido";
                  return null;
                },
              ),
              const SizedBox(height: 15),
              
              // Campo de Contraseña con validación de longitud (Requisito 1.2)
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Contraseña", border: OutlineInputBorder()),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return "La contraseña es obligatoria";
                  if (value.length < 6) return "Debe tener al menos 6 caracteres";
                  return null;
                },
              ),
              const SizedBox(height: 25),
              
              // Botón reactivo que cambia a carga cuando isLoading es true
              Obx(() => authController.isLoading.value 
                ? const CircularProgressIndicator() 
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authController.login(_emailController.text, _passwordController.text);
                        }
                      },
                      child: const Text("Ingresar"),
                    ),
                  )
              ),
              
              TextButton(
                onPressed: () => Navigator.push(context, 
                  MaterialPageRoute(builder: (_) => RegisterView())
                ),
                child: const Text("¿No tienes cuenta? Regístrate aquí"),
              )
            ],
          ),
        ),
      ),
    );
  }
}