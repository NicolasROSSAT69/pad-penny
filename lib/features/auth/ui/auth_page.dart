import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pad_penny/features/auth/ui/widgets/signin/auth_signin.dart';

import '../../home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            // L'utilisateur n'est pas connecté
            return const AuthSignin();
          } else {
            // L'utilisateur est connecté
            return const HomePage();
          }
        } else {
          // Le flux n'est pas encore prêt
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
