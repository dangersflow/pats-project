import 'package:flutter/material.dart';
import 'package:pats_project/components/login_card.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  //log in controllers
  TextEditingController _loginUserName = TextEditingController();
  TextEditingController _loginPassword = TextEditingController();

  //registration controllers
  TextEditingController _signUpUserName = TextEditingController();
  TextEditingController _signUpPassword = TextEditingController();
  TextEditingController _signUpEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Center(child: LogInSignUp()),
    );
  }
}
