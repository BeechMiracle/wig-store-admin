import 'package:flutter/material.dart';

import 'constants.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class ErrorText {
  static showSnackBar(String? text) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(
        text,
        style:
            kTitleTextStyle.copyWith(color: Colors.red.shade600, fontSize: 12),
      ),
      backgroundColor: kSecondaryColor,
      elevation: 5,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
