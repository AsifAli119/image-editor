import 'package:editor/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToEditingScreen();
  }

  _navigateToEditingScreen() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen(),
    ));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 150),
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 55),
                child: Image.asset("assets/images/creative.png", fit: BoxFit.cover,)),
            Text(
              "Celebrare",
              style: GoogleFonts.dancingScript(
                  textStyle: const TextStyle(
                      color: Colors.grey, fontSize: 40
                  )
              ),

            ),
          ],
        ),
      ),
    );
  }
}
