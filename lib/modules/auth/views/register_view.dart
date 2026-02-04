import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';

class RegisterView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmEmailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();

  Widget _buildCustomInput({
    required TextEditingController controller, 
    required String label, 
    required IconData icon,
    String? Function(String?)? validator,
  }){
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: const Color(0xFFF5F7F9),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("Bodytech App - Register")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person_add_rounded, size: 80, color: Colors.blue),
                  const Text("Regístrate", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 30),

                  _buildCustomInput(
                    controller: _nameController,
                    label: "Nombre",
                    icon: Icons.person_outline,
                    validator: (value) {
                      if(value == null || value.isEmpty) return "El nombre es obligatorio";
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  _buildCustomInput(
                    controller: _lastNameController,
                    label: "Apellido",
                    icon: Icons.person_outline,
                    validator: (value) {
                      if(value == null || value.isEmpty) return "El apellido es obligatorio";
                      return null;
                    }
                  ),
                  const SizedBox(height: 10),

                  _buildCustomInput(
                    controller: _emailController,
                    label: "Correo Electrónico",
                    icon: Icons.email_outlined,
                    validator: (value) {
                      if(value == null || value.isEmpty) return "El correo es obligatorio";
                      if(!GetUtils.isEmail(value)) return "Ingresa un correo válido";
                      return null;
                    }
                  ),
                  const SizedBox(height: 10),

                  _buildCustomInput(
                    controller: _confirmEmailController,
                    label: "Confirma tu correo",
                    icon: Icons.email_outlined,
                    validator: (value) {
                      if(value == null || value.isEmpty) return "La confirmación de correo es obligatoria";
                      if(value != _emailController.text) return "Los correos no coinciden";
                      return null;
                    }
                  ),
                  const SizedBox(height: 10),

                  PasswordInput(
                    controller: _passwordController,
                    label: "Contraseña",
                    validator: (value) {
                      if(value == null || value.isEmpty) return "La contraseña es obligatoria";
                      if(value.length < 6) return "Debe tener al menos 6 caracteres";
                      return null;
                    }
                  ),
                  const SizedBox(height: 10),

                  PasswordInput(
                    controller: _confirmPasswordController,
                    label: "Confirma tu contraseña",
                    validator: (value) {
                      if(value == null || value.isEmpty) return "La confirmación de contraseña es obligatoria";
                      if(value != _passwordController.text) return "Las contraseñas no coinciden";
                      return null;
                    }
                  ),
                  const SizedBox(height: 10),

                  Obx(() => authController.isLoading.value 
                    ? const CircularProgressIndicator() 
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()) {
                              authController.register(_emailController.text, _passwordController.text);
                            }
                          },
                          child: const Text("Registrarse"),
                        ),
                      )
                  ),
                ],
              ),
            )
          )
        )
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  PasswordInput({super.key, required this.controller, required this.label, this.validator});

  final RxBool _obscure = true.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextFormField(
      controller: controller,
      obscureText: _obscure.value,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(_obscure.value ? Icons.visibility_off : Icons.visibility),
          onPressed: () => _obscure.toggle(),
        ),
        filled: true,
        fillColor: const Color(0xFFF5F7F9),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    ));
  }
}