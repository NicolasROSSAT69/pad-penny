import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'core/firebase_initializer.dart';
import 'features/auth/ui/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PadPenny',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: FlutterSplashScreen.fadeIn(
        backgroundColor: Colors.white,
        onInit: () {
          debugPrint("On Init");
        },
        onEnd: () {
          debugPrint("On End");
        },
        childWidget: SizedBox(
          height: 200,
          width: 200,
          child: SvgPicture.asset(
            "assets/icons/icons8-flutter.svg",
            height: 100, width: 100,
          ),
        ),
        onAnimationEnd: () => debugPrint("On Fade In End"),
        defaultNextScreen: const AuthPage(),
      ),
    );
  }
}
