import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthHeaderSignup extends StatelessWidget {
  const AuthHeaderSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/icons/icons8-flutter.svg",
            height: 100, width: 100,
          ),
          Text(
              "Montes à bord !",
              style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              )

          ),
          Text(
            "Crée ton profile",
            style: GoogleFonts.poppins(),
          )
        ],
      ),
    );
  }
}
