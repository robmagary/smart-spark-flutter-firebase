import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartspark/features/user_auth/implementation/firebase_auth_services.dart';
import 'package:smartspark/features/user_auth/presentation/pages/home_page.dart';
import 'package:smartspark/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:smartspark/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:smartspark/helpers/ui_helpers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
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
          title: const Text("Login"),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  sizedBox30,
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
                              _signIn();
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
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                      )),
                  sizedBox10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Sign up",
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

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    setState(() {
      _isLoading = true;
    });

    User? user = await _auth.signInWithEmailAndPassword(email, password);

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
