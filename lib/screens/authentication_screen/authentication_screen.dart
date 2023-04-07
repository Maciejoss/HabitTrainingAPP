// ignore: file_names
import 'package:flutter/material.dart';

import 'Authentication_Pages/log_in_widget.dart';
import 'Authentication_Pages/sign_up_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LogInWidget(onClickedSignUp: toggle)
      : SignUpWidget(onClickedSignUp: toggle);

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
