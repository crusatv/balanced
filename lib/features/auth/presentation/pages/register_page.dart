import 'package:balanced/features/auth/presentation/components/continue_with_button.dart';
import 'package:balanced/features/auth/presentation/components/login_button.dart';
import 'package:balanced/features/auth/presentation/components/login_texfield.dart';
import 'package:balanced/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePage;

  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final String _emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  final String _passwordRegex = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';

  void register() {
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    final authCubit = context.read<AuthCubit>();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }
    // Validate email
    if (!RegExp(_emailRegex).hasMatch(email)) {
      // Show error for invalid email
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Correo electrónico no válido')),
      );
      return;
    }

    // Validate password
    if (!RegExp(_passwordRegex).hasMatch(password)) {
      // Show error for invalid password
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('La contraseña debe tener al menos 8 caracteres, '
                '1 letra y 1 número')),
      );
      return;
    }

    // Check if passwords match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    authCubit.signUp(email, password);

    @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
      super.dispose();
    }

    dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image(image: AssetImage("assets/img/LogoBlack.png"), height: 30),
              const SizedBox(height: 40),
              Text("Crea una cuenta para empezar",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
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
              LoginTexfield(
                controller: confirmPasswordController,
                hintText: "Repetir contraseña",
                obscureText: true,
              ),
              const SizedBox(height: 20),
              LoginButton(onTap: register, text: "Registrarse"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ya tienes cuenta? ", style: TextStyle(fontSize: 12)),
                  GestureDetector(
                    onTap: widget.togglePage,
                    child: Text("Inicia sesión",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        )),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Colors.grey,
                thickness: 0.6,
              ),
              const SizedBox(height: 20),
              ContinueWithButton(
                  onTap: () {},
                  text: "Continúa con Google",
                  imagePath: "assets/img/googleg.png"),
              const SizedBox(height: 10),
              ContinueWithButton(
                  onTap: () {},
                  text: "Continúa con Apple",
                  imagePath: "assets/img/apple.png"),
              const SizedBox(height: 20),
            ],
          ),
        ),
      )),
    );
  }
}
