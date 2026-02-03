import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Registro de usuario
  Future<UserCredential> signUp(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password,
    );
  }

  // Inicio de sesión
  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password,
    );
  }

  // Cierre de sesión
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Obtener usuario actual
  User? get currentUser => _auth.currentUser;
}