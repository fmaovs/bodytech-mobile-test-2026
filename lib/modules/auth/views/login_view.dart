import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4F4),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.fitness_center, size: 80, color: Color(0xFFEB6608)),
                const SizedBox(height: 20),
                const Text("BODYTECH POKÉDEX",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF2B2D2E), letterSpacing: 1.5)),
                const Text("Entrena tu conocimiento", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 40),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Correo Electrónico",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFFEB6608)),
                  ),
                  validator: (value) => (value == null || !GetUtils.isEmail(value)) ? "Correo inválido" : null,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFEB6608)),
                  ),
                  validator: (value) => (value == null || value.length < 6) ? "Mínimo 6 caracteres" : null,
                ),
                const SizedBox(height: 30),

                Obx(() => authController.isLoading.value
                    ? const CircularProgressIndicator(color: Color(0xFFEB6608))
                    : SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEB6608),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authController.login(_emailController.text, _passwordController.text);
                      }
                    },
                    child: const Text("INICIAR SESIÓN", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                )
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Get.to(() => RegisterView()),
                  child: const Text("¿No tienes cuenta? Regístrate aquí", style: TextStyle(color: Color(0xFF2B2D2E))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}