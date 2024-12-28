import 'package:clrmyway/pages/Home.dart';
import 'package:clrmyway/pages/Officer/login.dart';
import 'package:clrmyway/pages/Officer/register.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initalizing the login page
  bool showLoginPage = true;
  bool showHomePage = true;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  void toggleHome() {
    setState(() {
      showHomePage = !showHomePage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showHomePage) {
      return HomeScreen(onTap: toggleHome);
    } else if (showLoginPage) {
      return OfficerLogin(onTap: togglePages);
    } else {
      return OfficerRegister(onTap: togglePages);
    }
  }
}
