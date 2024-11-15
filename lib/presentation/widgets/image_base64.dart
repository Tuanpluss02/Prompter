import 'dart:convert';

import 'package:flutter/cupertino.dart';

Widget getImageBase64({required String image, width}) {
  const Base64Codec base64 = Base64Codec();
  final bytes = base64.decode(image);
  return Image.memory(
    bytes,
    width: width,
    height: width,
    fit: BoxFit.fill,
    errorBuilder: (context, error, stackTrace) {
      return const SizedBox(
        height: 40,
        child: CupertinoActivityIndicator(
          animating: true,
        ),
      );
    },
  );
}
