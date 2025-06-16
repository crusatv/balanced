import 'package:balanced/features/auth/data/firebase_auth_repo.dart';
import 'package:balanced/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:balanced/features/mainScreen/presentation/pages/main_screen.dart';
import 'package:balanced/features/splash/pages/splash.dart';
import 'package:balanced/firebase_options.dart';
import 'package:balanced/themes/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // Firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final firebaseAuthRepo = FirebaseAuthRepo();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
              create: (context) =>
                  AuthCubit(authRepo: firebaseAuthRepo)..checkAuth())
        ],
        child: MaterialApp(
            title: 'Balanced+',
            theme: lightModeTheme,
            debugShowCheckedModeBanner: false,
            home: const SplashPage()));
  }
}
