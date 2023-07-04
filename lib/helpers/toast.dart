import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SnackBarWidget {
  static void showError(String? message) {
    Fluttertoast.showToast(
      msg: message ?? "Successfully done",
      backgroundColor: Colors.green,
      gravity: ToastGravity.SNACKBAR,
    );
  }

  static void showSuccess(String? message) {
    Fluttertoast.showToast(
      msg: message ?? "Something went wrong",
      backgroundColor: Colors.red,
      gravity: ToastGravity.SNACKBAR,
    );
  }
}
