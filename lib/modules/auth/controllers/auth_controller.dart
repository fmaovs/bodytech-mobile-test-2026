import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/providers/auth_provider.dart' as custom;

class AuthController extends GetxController {
  final custom.AuthProvider _authProvider = custom.AuthProvider();

  // Variables reactivas (Observables)
  var isLoading = false.obs;
  var user = Rxn<User>(); // Usuario que puede ser nulo

  @override
  void onInit() {
    super.onInit();
    // Escuchar cambios en el estado de autenticación de Firebase
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  // Lógica de Login
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _authProvider.signIn(email, password);
      Get.offAllNamed('/home'); // Navegar a Home y limpiar historial [cite: 26]
    } catch (e) {
      Get.snackbar("Error de Login", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Lógica de Registro con validación manual extra
  Future<void> register(String email, String password) async {
    if (password.length < 6) { // Requisito técnico 
      Get.snackbar("Error", "La contraseña debe tener al menos 6 caracteres");
      return;
    }
    
    try {
      isLoading.value = true;
      await _authProvider.signUp(email, password);
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Error de Registro", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}