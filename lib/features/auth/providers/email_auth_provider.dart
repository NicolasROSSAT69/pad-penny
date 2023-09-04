import 'package:firebase_auth/firebase_auth.dart';

class MyEmailAuthProvider {
  static Future<UserCredential> signInWithEmail(String emailAddress, String password) async {

    final credential =  await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password
    );
    if (credential != null){
      return credential;
    }
    else {
      print("User is null");
      throw Error();
    }

  }

  static Future<UserCredential> signUpWithEmail(String emailAddress, String password) async {

    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    if (credential != null){
      return credential;
    }
    else {
      print("User is null");
      throw Error();
    }

  }
}
