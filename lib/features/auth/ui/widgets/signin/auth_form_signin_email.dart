import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../auth_service.dart';

class AuthFormSigninEmail extends StatefulWidget {

  final AuthService authService;
  const AuthFormSigninEmail({super.key, required this.authService});

  @override
  State<AuthFormSigninEmail> createState() => _AuthFormSigninEmailState();
}

class _AuthFormSigninEmailState extends State<AuthFormSigninEmail> {

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 25, left: 35, right: 35),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              style: GoogleFonts.poppins(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Champ obligatoire";
                }
                return null;
              },
              controller: emailController,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 35, right: 35),
            child: TextFormField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              ),
              style: GoogleFonts.poppins(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Champ obligatoire";
                }
                return null;
              },
              controller: passwordController,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 35, right: 35),
            child: SizedBox(
              //height: 30,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    // Pour le validator
                    if (_formKey.currentState!.validate()){

                      //Récupérer la valeur des champs
                      final email = emailController.text;
                      final password = passwordController.text;

                      //Afficher un message temporaire
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Connection en cours..."))
                      );
                      //Pour fermer le clavier
                      FocusScope.of(context).requestFocus(FocusNode());
                      await widget.authService.signInWithEmail(email, password);
                    }
                  },
                  child: Text(
                      "SE CONNECTER",
                    style: GoogleFonts.poppins(),
                  )
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 35, right: 35),
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Non développé')));
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(5, 5),
                alignment: Alignment.centerLeft,
              ),
              child: Text(
                'Mot de passe oublié ?',
                style: GoogleFonts.poppins(
                    color: Colors.blue
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
