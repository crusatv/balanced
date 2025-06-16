import 'package:balanced/features/auth/presentation/components/loading.dart';
import 'package:balanced/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balanced/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:balanced/features/auth/presentation/cubits/auth_states.dart';
import 'package:balanced/features/auth/presentation/pages/auth_page.dart'; // Si tienes uno

class ProfileWrapperPage extends StatelessWidget {
  const ProfileWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const LoadingScreen();
        } else if (state is AuthAuthenticated) {
          return const ProfilePage();
        } else {
          return const AuthPage(); // login/register
        }
      },
    );
  }
}
