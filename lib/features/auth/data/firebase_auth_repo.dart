import 'package:firebase_auth/firebase_auth.dart';

import '../domain/entities/app_user.dart';
import '../domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: userCredential.user?.email ?? '',
      );

      return user;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  @override
  Future<AppUser?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: userCredential.user?.email ?? '',
      );

      return user;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) {
        throw Exception('No user is currently signed in.');
      }

      await user.delete();
      await signOut();
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) {
        return null;
      }

      return AppUser(
        uid: user.uid,
        email: user.email!,
      );
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return 'Password reset email sent successfully. Check your inbox.';
    } catch (e) {
      throw Exception('Failed to send password reset email: $e');
    }
  }
}
