import 'package:flutter/material.dart';

Future<T?> pushScreen<T extends Object?>(
  BuildContext context,
  Widget page,
) async {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ),
  );
}
