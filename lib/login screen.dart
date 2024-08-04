import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled1_admin/constants.dart';
import 'package:untitled1_admin/error%20message.dart';
import 'package:untitled1_admin/main.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future logIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: kInactiveColor,
        ),
      ),
      barrierDismissible: false,
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      ErrorText.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/screen.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                const SizedBox(
                  width: 200,
                  child: Image(
                    image: AssetImage('images/image1.png'),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: kTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: emailController,
                      cursorColor: kButtonColor.withOpacity(0.2),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      style: kTitleTextStyle.copyWith(
                          fontWeight: FontWeight.normal, letterSpacing: 0),
                      decoration: textFieldStyle.copyWith(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                            color: kInactiveColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade600,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Password',
                      style: kTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      cursorColor: kButtonColor.withOpacity(0.2),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      style: kTitleTextStyle.copyWith(
                          fontWeight: FontWeight.normal, letterSpacing: 0),
                      decoration: textFieldStyle.copyWith(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                            color: kInactiveColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.shade600,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: logIn,
                  style: TextButton.styleFrom(
                    backgroundColor: kButtonColor,
                    fixedSize: const Size(150, 50),
                    elevation: 5,
                  ),
                  child: Text(
                    'Login',
                    style: kTitleTextStyle.copyWith(color: kSecondaryColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
