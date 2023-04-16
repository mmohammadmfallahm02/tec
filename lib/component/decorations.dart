import 'package:flutter/material.dart';
import '../constant/my_color.dart';

class MyDecoration {
  MyDecoration._();

  static const BoxDecoration mainGradient = BoxDecoration(
      gradient: LinearGradient(colors: GradientColors.bottomNav),
      borderRadius: BorderRadius.all(Radius.circular(26)));
}
