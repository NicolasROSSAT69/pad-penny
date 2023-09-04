import 'package:flutter/material.dart';

import 'auth/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthService _authService = AuthService();

  String userEmail = "Inconnu";

  @override
  void initState() {
    super.initState();
    final user = AuthService().getCurrentUser();
    if (user != null) {
      userEmail = user.email ?? "Inconnu";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Accueil"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.power_settings_new),
              tooltip: 'Se déconnecter',
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Deconnexion...')));
                await _authService.signOut();
              },
            ),
          ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Home page"),
            Text("Utilisateur connecté : $userEmail")
          ],
        ),
      ),
    );
  }
}

