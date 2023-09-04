import 'package:flutter/material.dart';
import '../../auth_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButtons extends StatelessWidget {
  final AuthService authService;

  const AuthButtons({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 35, right: 35),
      child: Column(
        children: [
          Text(
              "Ou",
              style: GoogleFonts.poppins()
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await authService.signInWithGoogle();
                },
                icon: SvgPicture.asset(
                  "assets/icons/icons8-logo-google.svg",
                  height: 18.0, width: 18.0,
                ),
                label: Text(
                  "Se connecter avec Google",
                  style: GoogleFonts.poppins(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
