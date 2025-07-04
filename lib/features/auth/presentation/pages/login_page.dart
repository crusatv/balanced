import 'package:balanced/features/auth/presentation/components/continue_with_button.dart';
import 'package:balanced/features/auth/presentation/components/login_button.dart';
import 'package:balanced/features/auth/presentation/components/login_texfield.dart';
import 'package:balanced/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:balanced/features/auth/presentation/cubits/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePage;
  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    final String email = emailController.text;
    final String password = passwordController.text;

    final authCubit = context.read<AuthCubit>();

    // Aquí puedes agregar la lógica de autenticación
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    authCubit.signIn(email, password).then((_) {
      if (authCubit.state is AuthAuthenticated) {
        // Navegar a la página principal o mostrar un mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inicio de sesión exitoso')),
        );
      } else if (authCubit.state is AuthError) {
        // Mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
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
              Text("Inicia sesión para continuar",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("¿Has olvidado la contraseña?",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 20),
              LoginButton(onTap: login, text: "Iniciar sesión"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("¿No tienes cuenta? ", style: TextStyle(fontSize: 12)),
                  GestureDetector(
                    onTap: widget.togglePage,
                    child: Text("Regístrate ahora",
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
                  onTap: () async {
                    authCubit.signInWithGoogle();
                  },
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
