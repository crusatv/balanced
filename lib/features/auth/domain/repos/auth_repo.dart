import '../entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> signInWithEmailAndPassword(String email, String password);
  Future<AppUser?> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<AppUser?> getCurrentUser();
  Future<void> deleteAccount();
  Future<String> sendPasswordResetEmail(String email);
}
