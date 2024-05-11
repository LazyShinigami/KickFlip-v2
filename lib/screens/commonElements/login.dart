import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/firebase/authHandler.dart';
import 'package:kickflip/screens/commonElements/loadingScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.callback});
  final VoidCallback callback;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String accountType = 'buyer';

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final pwdController = TextEditingController();
    final resetPwdController = TextEditingController();
    String errorMessage = '';

    // Validator
    LoginValidator() {
      // Check if any of the values are null
      if (emailController.text.trim().isEmpty || pwdController.text.isEmpty) {
        errorMessage = 'All fields mandatory!';
      }

      // Check if email is provided and valid
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(emailController.text.trim())) {
        errorMessage = 'Enter a valid e-mail address!';
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyText("Login", size: 22, spacing: 3, weight: FontWeight.bold),
                const SizedBox(height: 20),

                // Error Message
                if (errorMessage.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: MyText(
                      errorMessage,
                      size: 12,
                      color: const Color.fromARGB(196, 244, 67, 54),
                    ),
                  ),
                // spacing
                if (errorMessage.isEmpty) const SizedBox(height: 20),

                // === Form fields ===
                // E-mail field
                MyTextField(
                  controller: emailController,
                  label: "E-Mail",
                  hint: 'Enter your e-mail',
                ),
                const SizedBox(height: 10),

                // Password field
                MyTextField(
                    controller: pwdController,
                    label: "Password",
                    hint: 'Enter your password',
                    obscureText: true),
                const SizedBox(height: 10),

                // Submit button
                GestureDetector(
                  onTap: () async {
                    print("Submit button clicked");
                    LoginValidator();
                    if (errorMessage.isNotEmpty) {
                      setState(() {});
                    } else {
                      var x = await AuthService().signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: pwdController.text,
                      );
                      print(x);
                      // print('VALUE OF X -----> ${x.toString()}');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadingScreen(user: x)),
                          (route) => false);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 70,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/graphics/op-02.jpeg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: MyText(
                        'Continue',
                        size: 14,
                        spacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                //
                MyText(' -   or   - ', size: 12),
                const SizedBox(height: 15),

                // Google sign-in button
                GestureDetector(
                  onTap: () {
                    print('Continue with Google button pressed');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/graphics/op-03.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(500),
                          ),
                          child: Image.asset('assets/google.png'),
                        ),
                        const SizedBox(width: 20),
                        MyText(
                          'Continue with Google',
                          size: 14,
                          spacing: 2,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),

                // Sign-up link
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    print("Forgot your password?");
                    showResetPasswordPopup(context, resetPwdController);
                  },
                  child: MyText(
                    'Forgot your password?',
                    size: 12,
                    spacing: 1,
                    weight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      'Don\'t have an account yet?',
                      size: 12,
                      spacing: 1,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Sign up button tapped");
                        widget.callback();
                      },
                      child: MyText(
                        ' Sign up now!',
                        size: 12,
                        spacing: 1,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showResetPasswordPopup(
      BuildContext context, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext childContext) {
        return AlertDialog(
          title: Column(
            children: [
              MyText(
                'Aww! We\'re sorry to here you have trouble logging in...',
                size: 13,
                spacing: 1.25,
              ),
              const SizedBox(height: 10),
              const Divider(),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                MyText(
                  'Enter your e-mail. We will send a reset e-mail. Follow it and you\'re done!',
                  size: 12,
                  spacing: 1,
                ),
                // E-mail text field
                const SizedBox(height: 20),
                MyTextField(controller: controller, label: 'E-mail'),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Send reset e-mail button
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/graphics/op-02.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: MyText(
                        'Continue',
                        color: Colors.white,
                        size: 12,
                        spacing: 1,
                      ),
                    ),
                  ),
                ),

                // Cancel Button
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Center(
                      child: MyText(
                        'Cancel',
                        color: Colors.black,
                        size: 12,
                        spacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
