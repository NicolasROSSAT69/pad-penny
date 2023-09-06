import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'auth/auth_service.dart';
import 'auth/providers/user_model.dart';
import 'navigation/bottom_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    final user = AuthService().getCurrentUser();
    if (user != null) {
      Provider.of<UserModel>(context, listen: false).setUserEmail(user.email ?? "Inconnu");
      Provider.of<UserModel>(context, listen: false).setUserUid(user.uid ?? "Inconnu");
      Provider.of<UserModel>(context, listen: false).setUserName(user.displayName ?? "Inconnu");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("PadPenny", style: GoogleFonts.poppins()),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.power_settings_new),
              tooltip: 'Se déconnecter',
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Deconnexion...', style: GoogleFonts.poppins())));
                await _authService.signOut();
              },
            ),
          ]
      ),
      body: const BottomNavigation()
    );
  }
}

