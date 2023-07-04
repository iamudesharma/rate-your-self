import 'package:rate_your_self/helpers/toast.dart';
import 'package:rate_your_self/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../error/error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as ri;

final authRepoProvider = ri.Provider<AuthRepo>((ref) {
  return AuthRepo(ref.read(supabaseProvider)) ;
});

final class AuthRepo {
  final SupabaseClient supabase;

  AuthRepo(this.supabase);

  Future<AuthResponse> signUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
      );

      SnackBarWidget.showSuccess("Successfully signed up");
      return res;
    } catch (e) {
      SnackBarWidget.showError(e.toString());
      throw AppError(
        message: e.toString(),
      );
    }
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      SnackBarWidget.showSuccess("Successfully login up");

      return res;
    } catch (e) {
      SnackBarWidget.showError(e.toString());

      throw AppError(
        message: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
      SnackBarWidget.showSuccess("Successfully sign out");
    } catch (e) {
      SnackBarWidget.showError(e.toString());

      throw AppError(
        message: e.toString(),
      );
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
      SnackBarWidget.showSuccess("Successfully sent email");
    } catch (e) {
      SnackBarWidget.showError(e.toString());

      throw AppError(
        message: e.toString(),
      );
    }
  }
}
