import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  // Constructor: Obtiene el estado de autenticación al iniciar
  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Método para registrar un usuario
  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("Error en registro: $e");
    }
  }

  // Método para iniciar sesión
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("Error en login: $e");
    }
  }

  // Método para cerrar sesión
  Future<void> logout() async {
    await _auth.signOut();
  }
}
