import 'package:supabase_flutter/supabase_flutter.dart';

import '../../error/error.dart';

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
      return res;
    } catch (e) {
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
      return res;
    } catch (e) {
      throw AppError(
        message: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw AppError(
        message: e.toString(),
      );
    }
  }
}
