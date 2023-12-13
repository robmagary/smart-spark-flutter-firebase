import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartspark/features/user_auth/implementation/firebase_auth_services.dart';
import 'package:smartspark/features/user_auth/presentation/pages/home_page.dart';
import 'package:smartspark/features/user_auth/presentation/pages/login_page.dart';
import 'package:smartspark/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:smartspark/helpers/ui_helpers.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox30 = SizedBox(
      height: 30,
    );
    const sizedBox10 = SizedBox(
      height: 10,
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign up"),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  sizedBox30,
                  FormContainerWidget(
                    controller: _usernameController,
                    hintText: "Username",
                    isDiabled: _isLoading,
                    isPasswordField: false,
                  ),
                  sizedBox10,
                  FormContainerWidget(
                    controller: _emailController,
                    hintText: "Email",
                    isDiabled: _isLoading,
                    isPasswordField: false,
                  ),
                  sizedBox10,
                  FormContainerWidget(
                    controller: _passwordController,
                    hintText: "Password",
                    isDiabled: _isLoading,
                    isPasswordField: true,
                  ),
                  sizedBox30,
                  GestureDetector(
                      onTap: _isLoading
                          ? null
                          : () {
                              _signUp();
                            },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: _isLoading
                                ? const LoadingWidget()
                                : const Text(
                                    "Sign up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                      )),
                  sizedBox10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              (route) => false);
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    setState(() {
      _isLoading = true;
    });

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    setState(() {
      _isLoading = false;
    });

    if (user != null && context.mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    } else {
      return null;
    }
  }
}
