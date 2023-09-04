import 'package:firebase_auth/firebase_auth.dart';
import 'package:pad_penny/features/auth/providers/email_auth_provider.dart';
import 'providers/google_auth_provider.dart';
//import 'providers/facebook_auth_provider.dart';

class AuthService {
  Future<UserCredential> signInWithGoogle() async {
    return await MyGoogleAuthProvider.signInWithGoogle();
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await MyEmailAuthProvider.signInWithEmail(email, password);
  }

  /*Future<UserCredential> signInWithFacebook() async {
    return await FacebookAuthProvider.signInWithFacebook();
  }*/
  Future<UserCredential> signUpWithEmail(String email, String password) async {
    return await MyEmailAuthProvider.signUpWithEmail(email, password);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
