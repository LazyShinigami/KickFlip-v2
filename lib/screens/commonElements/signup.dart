import 'package:flutter/material.dart';
import 'package:kickflip/commons.dart';
import 'package:kickflip/constants.dart';
import 'package:kickflip/firebase/authHandler.dart';
import 'package:kickflip/screens/buyers/buyerHomepage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.callback});
  final VoidCallback callback;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String accountType = 'buyer';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final pwdController = TextEditingController();

    SignUpValidator() {
      // Check if any of the values are null
      if (emailController.text.trim().isEmpty ||
          pwdController.text.isEmpty ||
          nameController.text.trim().isEmpty) {
        errorMessage = 'All fields mandatory!';
      }

      // Check if email is provided and valid
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(emailController.text.trim())) {
        errorMessage = 'Enter a valid e-mail address!';
      }

      // Check if password is at least 8 characters long
      if (pwdController.text.length < 8) {
        errorMessage = 'Password is too short!';
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyText("Sign Up",
                    size: 22, spacing: 3, weight: FontWeight.bold),
                const SizedBox(height: 20),

                // Account type switch
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Buyer
                    GestureDetector(
                      onTap: () {
                        accountType = "buyer";
                        setState(() {});
                        print(accountType);
                      },
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 15, vertical: 3),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.grey),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          image: (accountType == 'buyer')
                              ? const DecorationImage(
                                  image:
                                      AssetImage('assets/graphics/op-03.jpeg'),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: MyText(
                          'Buyer',
                          size: 14,
                          color: (accountType == 'buyer')
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),

                    // Seller
                    GestureDetector(
                      onTap: () {
                        accountType = "seller";
                        setState(() {});
                        print(accountType);
                      },
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 15, vertical: 3),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.grey),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          image: (accountType == 'seller')
                              ? const DecorationImage(
                                  image:
                                      AssetImage('assets/graphics/op-03.jpeg'),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: MyText(
                          'Seller',
                          size: 14,
                          color: (accountType == 'seller')
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

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

                // Form fields
                if (errorMessage.isEmpty) const SizedBox(height: 20),

                // Username field
                MyTextField(
                  controller: nameController,
                  label: "Name",
                  hint: 'Enter your name',
                ),
                const SizedBox(height: 10),

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
                    hint: "Choose a strong password",
                    obscureText: true),
                const SizedBox(height: 10),

                // Submit button
                GestureDetector(
                  onTap: () async {
                    print("Submit button clicked");

                    SignUpValidator();
                    if (errorMessage.isNotEmpty) {
                      setState(() {});
                    } else {
                      var x = await AuthService().signUpWithUserCredentials(
                        name: nameController.text,
                        type: accountType,
                        email: emailController.text,
                        password: pwdController.text,
                      );
                      if (x.runtimeType == String && x.toString().isNotEmpty) {
                        errorMessage = x;
                      }
                    }
                    setState(() {});

                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => BuyerHomepage(uID: 5678),
                    //     ),
                    //     (route) => false);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 70,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/graphics/op-03.jpeg'),
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
                        image: AssetImage('assets/graphics/op-02.jpeg'),
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

                // Login link
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      'Already have an account?',
                      size: 12,
                      spacing: 1,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Login button tapped");
                        widget.callback();
                      },
                      child: MyText(
                        ' Login!',
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
}
