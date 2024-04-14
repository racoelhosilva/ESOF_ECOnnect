import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/firebase_options.dart';
import 'package:econnect/model/database.dart';
import 'package:econnect/view/home/home_page.dart';
import 'package:econnect/view/login/login_page.dart';
import 'package:econnect/view/login/register_page.dart';
import 'package:econnect/view/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final DatabaseController dbController = DatabaseController(db: Database());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECOnnect',
      theme: const MaterialTheme(TextTheme()).dark(),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        final transitions = {
          '/login': MaterialPageRoute<LoginPage>(
              builder: (_) => LoginPage(dbController: dbController)),
          '/home': MaterialPageRoute<HomePage>(
              builder: (_) => HomePage(dbController: dbController)),
          '/register': MaterialPageRoute<RegisterPage>(
              builder: (_) => RegisterPage(dbController: dbController)),
        };
        return transitions[settings.name];
      },
    );
  }
}
