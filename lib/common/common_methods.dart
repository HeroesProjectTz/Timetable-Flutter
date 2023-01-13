import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable/utils/colours.dart';

class CommonMethods {
  showSnackBarMessage(BuildContext c, String message) {
    return ScaffoldMessenger.of(c).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
        backgroundColor: blueColor,
        content: Text(message),
      ),
    );
  }
}

final commonMethodsProvider = Provider<CommonMethods>((ref) {
  return CommonMethods();
});
