import '../responses/reset_password_response.dart';
import '../responses/sign_in_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<User?> get user;
  Future<void> signOut();
  Future<SignInResponse> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<ResetPasswordResponse> sendResetPasswordLink(String email);
}
