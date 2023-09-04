import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pad_penny/features/auth/ui/widgets/signin/auth_signin.dart';
import 'package:pad_penny/features/auth/ui/widgets/signup/auth_signup.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              "assets/icons/icons8-flutter.svg",
              height: 380, width: 380,
            ),
            Text(
              "Créez une application géniale",
              style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              )
            ),
            Text(
              "Mettons votre créativité sur l'autoroute du développement",
              style: GoogleFonts.poppins(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AuthSignin()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1.5, color: Colors.teal),
                    ),
                    child: Text(
                      "SE CONNECTER",
                      style: GoogleFonts.poppins(),
                    )
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AuthSignup()),
                      );
                    },
                    child: Text(
                      "S'INSCRIRE",
                      style: GoogleFonts.poppins(),
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
