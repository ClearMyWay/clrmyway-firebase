// import 'package:clrmyway/pages/Officer/login.dart';
import 'package:clrmyway/components/custom_button.dart';
import 'package:clrmyway/components/custom_textfield.dart';
import 'package:flutter/material.dart';

class OfficerLogin extends StatelessWidget {
  final void Function()? onTap;
  OfficerLogin({super.key, required this.onTap});

  // Text editing controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Login method
  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),

              // email text field
              CustomTextField(
                  hintText: "Username",
                  obscureText: false,
                  controller: usernameController),

              const SizedBox(height: 10),

              // password text field
              CustomTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot Password?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                ],
              ),

              const SizedBox(height: 20),

              // login button
              CustomButton(text: "Login", onTap: login),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  GestureDetector(
                      onTap: onTap,
                      child: Text("Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
