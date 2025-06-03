import 'package:balanced/features/auth/presentation/components/login_button.dart';
import 'package:balanced/features/auth/presentation/components/login_texfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              "balanced+",
              style: TextStyle(fontSize: 32, fontFamily: "ArgentCF"),
            ),
            const SizedBox(height: 40),
            Text("Crea una cuenta para empezar",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            const SizedBox(height: 15),
            Text("Enter your email to create an account",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
            const SizedBox(height: 20),
            LoginTexfield(
              controller: emailController,
              hintText: "Correo electrónico",
              obscureText: false,
            ),
            const SizedBox(height: 10),
            LoginTexfield(
              controller: passwordController,
              hintText: "Contraseña",
              obscureText: true,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("¿Has olvidado la contraseña?",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 20),
            LoginButton(onTap: () {}, text: "Log In"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("¿No tienes cuenta? ", style: TextStyle(fontSize: 12)),
                Text("Regístrate ahora",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
