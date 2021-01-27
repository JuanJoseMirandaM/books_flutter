import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI{

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<auth.User> gmailSignIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

    auth.UserCredential userCredential = await _auth.signInWithCredential(
        auth.GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));

    return userCredential.user;
  }

  signOut() async {
    await _auth.signOut().then((value) => print("sesion cerrada"));
    googleSignIn.signOut();
    print("sessiones cerradas");
  }
  // Future<FirebaseUser> emailAndPasswordSignIn(String email, String password) async{
  //   AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
  //
  //   FirebaseUser user = authResult.user;
  //
  //   return user;
  // }
  //
  // Future<FirebaseUser> facebookSignIn() async {
  //
  //   final _facebookLogin = FacebookLogin();
  //   final result = await _facebookLogin.logIn(['email']);
  //
  //   switch (result.status){
  //     case FacebookLoginStatus.loggedIn:
  //       {
  //         AuthResult authResult = await _auth.signInWithCredential(
  //             FacebookAuthProvider.getCredential(
  //                 accessToken: result.accessToken.token));
  //
  //         FirebaseUser user = authResult.user;
  //
  //         return user;
  //         break;
  //       }
  //
  //     case FacebookLoginStatus.cancelledByUser:{
  //       print("Autenticación cancelada por el usuario");
  //       break;
  //     }
  //
  //     case FacebookLoginStatus.error:{
  //       print("Error: ${result.errorMessage.toString()}");
  //       break;
  //     }
  //   }
  // }
}