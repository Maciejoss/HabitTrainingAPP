import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habit_trainer/Services/habits_manage_service.dart';
import 'package:habit_trainer/items/data.dart';
import '../../../Services/todos_manage_service.dart';
import '../../../items/Habit.dart';
import '../../../items/todo.dart';
import '../../../main.dart';
import '../../../widgets/utils.dart';

class LogInWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LogInWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Form(
        key: formKey,
        child: Column(children: [
          const SizedBox(
            height: 150,
            child: Center(
              child: Icon(
                Icons.flutter_dash,
                size: 100,
              ),
            ),
          ),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Email'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? 'Enter a valid email'
                    : null,
          ),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (password) => password != null && password.length < 6
                ? 'password has min 6 characters'
                : null,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: signIn,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            icon: const Icon(
              Icons.lock_open,
              size: 32,
            ),
            label: const Text("Sign in"),
          ),
          ElevatedButton(onPressed: signInAdmin, child: const Text("loguj")),
          const SizedBox(
            height: 24,
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              text: 'No account?  ',
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickedSignUp,
                  text: 'Sign up',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      Data.dataLoaded = false;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Todo.todoList = await TodosManageService.readTodos();
      Habit.habitList = await HabitsManageService.readHabits();
      log(Habit.habitList.toString());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future signInAdmin() async {
    try {
      Data.dataLoaded = false;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'maciek@placek.com', password: 'haslo123');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }
}
