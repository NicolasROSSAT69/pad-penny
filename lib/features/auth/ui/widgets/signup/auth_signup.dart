import 'package:flutter/material.dart';
import '../../../auth_service.dart';
import '../auth_buttons.dart';
import 'auth_form_signup.dart';
import 'auth_header_signup.dart';

class AuthSignup extends StatefulWidget {
  const AuthSignup({super.key});

  @override
  State<AuthSignup> createState() => _AuthSignupState();
}

class _AuthSignupState extends State<AuthSignup> {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              const AuthHeaderSignup(),
              AuthFormSignup(authService: _authService),
              AuthButtons(authService: _authService),
            ],
          )
      ),
    );
  }
}
