import 'dart:math';

import 'package:flutter/material.dart';

class UtilOther {
  static fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode next,
      ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static hiddenKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static String getRandomNum(){
    Random random = Random();
    String number = '';
    for(int i = 0; i < 4; i++){
      number = number + random.nextInt(9).toString();
    }

    return number;
  }


  ///Singleton factory
  static final UtilOther _instance = UtilOther._internal();

  factory UtilOther() {
    return _instance;
  }

  UtilOther._internal();
}
