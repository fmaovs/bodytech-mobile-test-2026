import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4F4),
      appBar: AppBar(
        title: const Text("NUEVO ENTRENADOR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Únete a la comunidad Sangre Naranja", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 30),
              _buildField(_nameController, "Nombre Completo", Icons.person_outline),
              const SizedBox(height: 15),
              _buildField(_emailController, "Correo Electrónico", Icons.email_outlined, isEmail: true),
              const SizedBox(height: 15),
              _buildField(_passwordController, "Contraseña", Icons.lock_outline, isPass: true),
              const SizedBox(height: 30),
              Obx(() => authController.isLoading.value
                  ? const CircularProgressIndicator(color: Color(0xFFEB6608))
                  : SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B2D2E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      authController.register(_emailController.text, _passwordController.text);
                    }
                  },
                  child: const Text("CREAR CUENTA", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label, IconData icon, {bool isEmail = false, bool isPass = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPass,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFFEB6608)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      validator: (value) => (value == null || value.isEmpty) ? "Campo requerido" : null,
    );
  }
}