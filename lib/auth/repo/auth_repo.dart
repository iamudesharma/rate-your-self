import 'package:pocketbase/pocketbase.dart';
import 'package:rate_your_self/helpers/toast.dart';
import 'package:rate_your_self/main.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

import '../../error/error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as ri;

final authRepoProvider = ri.Provider<AuthRepo>((ref) {
  return AuthRepo(ref.read(supabaseProvider));
});

final class AuthRepo {
  final PocketBase pocketbase;

  AuthRepo(this.pocketbase);

  Future<RecordAuth> signUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final RecordAuth res =
          await pocketbase.collection("users").authWithPassword(
        email,
        password,
        body: {'username': username},
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

  Future<RecordAuth> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final RecordAuth res =
          await pocketbase.collection("users").authWithPassword(
                email,
                password,
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

  // Future<void> signOut() async {
  //   try {
  //     await supabase.collection("users").();
  //     SnackBarWidget.showSuccess("Successfully sign out");
  //   } catch (e) {
  //     SnackBarWidget.showError(e.toString());

  //     throw AppError(
  //       message: e.toString(),
  //     );
  //   }
  // }

  Future<void> forgotPassword({required String email}) async {
    // try {
    //   await supabase.collection("users").(email);
    //   SnackBarWidget.showSuccess("Successfully sent email");
    // } catch (e) {
    //   SnackBarWidget.showError(e.toString());

    //   throw AppError(
    //     message: e.toString(),
    //   );
    // }
  }
}
