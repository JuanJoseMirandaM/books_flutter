import 'package:books/User/repository/firebase_auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthRepository{
  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<auth.User> sigInGmail() => _firebaseAuthAPI.gmailSignIn();

  signOut() => _firebaseAuthAPI.signOut();

}