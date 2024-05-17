import 'package:econnect/controller/database_controller.dart';
import 'package:econnect/controller/session_controller.dart';
import 'package:econnect/view/login/widgets/login_button.dart';
import 'package:econnect/view/login/widgets/login_text_field.dart';
import 'package:econnect/view/login/widgets/register_button.dart';
import 'package:econnect/view/login/widgets/password_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.dbController,
    required this.sessionController,
  });

  final DatabaseController dbController;
  final SessionController sessionController;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Image.asset(
              'assets/png/logo_white.png',
              height: 250,
              fit: BoxFit.contain,
            ),
            Center(
              child: Text(
                'ECOnnect',
                style: TextStyle(
                  fontFamily: 'K2D',
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 270,
                child: Column(
                  children: [
                    LoginTextField(
                      fieldName: 'E-mail',
                      controller: emailController,
                    ),
                    PasswordField(controller: passwordController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const RegisterButton(),
                        LoginButton(
                          dbController: widget.dbController,
                          sessionController: widget.sessionController,
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
