import 'package:flutter/material.dart';
import '../../../auth_service.dart';
import '../auth_buttons.dart';
import 'auth_form_signin_email.dart';
import 'auth_header_signin.dart';

class AuthSignin extends StatefulWidget {
  const AuthSignin({super.key});

  @override
  State<AuthSignin> createState() => _AuthSigninState();
}

class _AuthSigninState extends State<AuthSignin> {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              const AuthHeaderSignin(),
              AuthFormSigninEmail(authService: _authService),
              AuthButtons(authService: _authService),
            ],
          )
      ),
    );
  }
}
