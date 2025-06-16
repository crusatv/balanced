import 'package:balanced/features/auth/domain/entities/app_user.dart';
import 'package:balanced/features/auth/domain/repos/auth_repo.dart';
import 'package:balanced/features/auth/presentation/cubits/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  AppUser? get currentUser => _currentUser;

  void checkAuth() async {
    emit(AuthLoading());

    final AppUser? user = await authRepo.getCurrentUser();
    if (user != null) {
      _currentUser = user;
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final AppUser? user =
          await authRepo.signInWithEmailAndPassword(email, password);
      if (user != null) {
        _currentUser = user;
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      final AppUser? user =
          await authRepo.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        _currentUser = user;
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await authRepo.signOut();
      _currentUser = null;
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    emit(AuthLoading());
    try {
      await authRepo.deleteAccount();
      _currentUser = null;
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<String> sendPasswordResetEmail(String email) async {
    emit(AuthLoading());
    try {
      final message = authRepo.sendPasswordResetEmail(email);
      emit(AuthPasswordResetSent(email));
      return message;
    } catch (e) {
      emit(AuthError(e.toString()));
      return e.toString();
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final AppUser? user = await authRepo.signInWithGoogle();
      if (user != null) {
        _currentUser = user;
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
      print("Error signing in with Google: $e");
    }
  }
}
