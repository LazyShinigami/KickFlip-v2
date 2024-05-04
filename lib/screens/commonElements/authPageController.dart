import 'package:flutter/material.dart';
import 'package:kickflip/screens/commonElements/login.dart';
import 'package:kickflip/screens/commonElements/signup.dart';

class AuthPageHandler extends StatefulWidget {
  const AuthPageHandler({super.key});

  @override
  State<AuthPageHandler> createState() => _AuthPageHandlerState();
}

class _AuthPageHandlerState extends State<AuthPageHandler> {
  // VoidCallback switchAuthPage()
  bool showLoginPage = true;

  @override
  Widget build(BuildContext context) {
    switchPage() {
      showLoginPage = !showLoginPage;
      setState(() {});
    }

    return (showLoginPage)
        ? LoginScreen(
            callback: switchPage,
          )
        : SignUpScreen(
            callback: switchPage,
          );
  }
}
