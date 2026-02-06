import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/providers/auth_provider.dart' as custom;

class AuthController extends GetxController {
  final custom.AuthProvider _authProvider = custom.AuthProvider();

  var isLoading = false.obs;
  var user = Rxn<User>(); 

  @override
  void onInit() {
    super.onInit();
    user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _authProvider.signIn(email, password);
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Error de Login", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String email, String password) async {
    if (password.length < 6) {
      Get.snackbar("Error", "La contraseña debe tener al menos 6 caracteres");
      return;
    }
    
    try {
      isLoading.value = true;
      await _authProvider.signUp(email, password);
      Get.snackbar("Éxito", "Cuenta creada correctamente", snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar("Error de Registro", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}