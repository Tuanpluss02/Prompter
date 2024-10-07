import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DialogLoading {
  static showLoading() {
    return EasyLoading.show(
      indicator: Center(
        child: LoadingAnimationWidget.prograssiveDots(
            color: Colors.deepPurple, size: 50),
      ),
    );
  }

  static dismissLoading() {
    EasyLoading.dismiss();
  }
}
