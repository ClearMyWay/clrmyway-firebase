// import 'package:clrmyway/pages/Officer/login.dart';
import 'package:clrmyway/components/custom_button.dart';
import 'package:clrmyway/components/custom_textfield.dart';
import 'package:flutter/material.dart';

class OfficerRegister extends StatefulWidget {
  final void Function()? onTap;

  const OfficerRegister({super.key, required this.onTap});

  @override
  State<OfficerRegister> createState() => _OfficerRegisterState();
}

class _OfficerRegisterState extends State<OfficerRegister> {
  // Text editing controllers
  final TextEditingController fullnameController = TextEditingController();

  final TextEditingController badgeController = TextEditingController();

  final TextEditingController rankController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController stationController = TextEditingController();

  // Login method
  void register() {}

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
                  hintText: "Full Name",
                  obscureText: false,
                  controller: fullnameController),

              const SizedBox(height: 10),

              // password text field
              CustomTextField(
                  hintText: "Badge Number",
                  obscureText: false,
                  controller: badgeController),

              const SizedBox(height: 10),

              // password text field
              CustomTextField(
                  hintText: "Rank or Designation",
                  obscureText: false,
                  controller: rankController),

              const SizedBox(height: 10),

              // password text field
              CustomTextField(
                  hintText: "Phone Number",
                  obscureText: false,
                  controller: phoneController),

              const SizedBox(height: 10),

              // password text field
              CustomTextField(
                  hintText: "Email Address",
                  obscureText: false,
                  controller: emailController),

              const SizedBox(height: 10),

              // password text field
              CustomTextField(
                  hintText: "Station Name",
                  obscureText: false,
                  controller: stationController),

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
              CustomButton(text: "Register", onTap: widget.onTap),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text("Login",
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
