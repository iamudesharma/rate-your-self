import 'package:pocketbase/pocketbase.dart';
import 'package:rate_your_self/helpers/logger.dart';
import 'package:rate_your_self/helpers/toast.dart';
import 'package:rate_your_self/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

import '../../error/error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as ri;

final authRepoProvider = ri.Provider<AuthRepo>((ref) {
  return AuthRepo(ref.read(pbProvider));
});

final class AuthRepo {
  final PocketBase pocketbase;
  // final SharedPreferences sharedPreferences;

  AuthRepo(this.pocketbase);

  Future<RecordModel> signUp(
      {required String email,
      required String password,
      required String username}) async {
    final body = <String, dynamic>{
      "username": username,
      "email": email,
      "emailVisibility": true,
      "password": password,
      "passwordConfirm": password,
    };
    try {
      final RecordModel res = await pocketbase.collection("users").create(
            body: body,
          );

      logger.i(res.toJson());

      // pocketbase.authStore.save(res.token, res.record);
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

      logger.i(res.toJson());

      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      preferences.setString("token", res.token);
      preferences.setString("username", res.record?.data["username"]);
      preferences.setString("email", res.record?.data["email"]);
      // preferences.setString("token", res.token);


      // pocketbase.authStore.save(res.token, res.record);
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
