import 'package:flutter/material.dart';
import 'package:smartspark/features/user_auth/presentation/pages/home_page.dart';
import 'package:smartspark/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:smartspark/features/user_auth/presentation/widgets/form_container_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  const FormContainerWidget(
                    hintText: "Email",
                    isPasswordField: false,
                  ),
                  sizedBox10,
                  const FormContainerWidget(
                    hintText: "Password",
                    isPasswordField: true,
                  ),
                  sizedBox30,
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                              (route) => false);
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
}
