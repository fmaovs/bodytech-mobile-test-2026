import 'package:bodytech_test/modules/auth/views/register_view.dart';
import 'package:bodytech_test/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  
  final _formKey = GlobalKey<FormState>();
  
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
              
              Obx(() => authController.isLoading.value 
                ? const CircularProgressIndicator() 
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authController.login(_emailController.text, _passwordController.text);
                          MaterialPageRoute(builder: (_) => HomeView());
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