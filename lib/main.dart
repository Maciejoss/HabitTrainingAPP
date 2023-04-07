import 'package:flutter/material.dart';
import 'package:habit_trainer/widgets/utils.dart';
import 'package:habit_trainer/screens/screens.dart';
import 'package:habit_trainer/themes.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme();

    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme.light,
      darkTheme: theme.dark,
      themeMode: ThemeMode.dark,
      home: const LoginCheck(),
    );
  }
}
