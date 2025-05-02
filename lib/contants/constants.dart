import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message, backgroundColor: Colors.red, textColor: Colors.white, toastLength: Toast.LENGTH_LONG);
  }

  static void flushBarErrorMessages(String message, BuildContext context, {title}) {
    showFlushbar(
      context: context,
      flushbar:
          Flushbar(
              forwardAnimationCurve: Curves.decelerate,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(15),
              titleColor: Theme.of(context).primaryIconTheme.color,
              borderRadius: BorderRadius.circular(10),
              reverseAnimationCurve: Curves.easeInOut,
              flushbarPosition: FlushbarPosition.TOP,
              positionOffset: 20,
              icon: Icon(Icons.error, color: Theme.of(context).primaryIconTheme.color, size: 28),
              message: message,
              backgroundColor: Theme.of(context).colorScheme.primary,
              duration: const Duration(seconds: 3),
              title: title,
              messageColor: Theme.of(context).primaryIconTheme.color,
            )
            ..show(context)
            ..duration,
    );
  }

  static snackBar(String message, BuildContext context, Color? color) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }
}
