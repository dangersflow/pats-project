import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class LogInSignUp extends StatefulWidget {
  const LogInSignUp({Key? key}) : super(key: key);

  @override
  _LogInSignUpState createState() => _LogInSignUpState();
}

class _LogInSignUpState extends State<LogInSignUp> {
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
        duration: const Duration(milliseconds: 300),
        reverse: !isLogin,
        child: isLogin
            ? Column(
                children: [
                  Text("I am Login"),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLogin = false;
                        });
                      },
                      child: Text("sign up"))
                ],
              )
            : Column(
                children: [
                  Text("I am signup"),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLogin = true;
                        });
                      },
                      child: Text("log in"))
                ],
              ),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        });
  }
}
